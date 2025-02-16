//
//  AudioManager.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 16/02/25.
//

import Speech
import AVFoundation

class AudioManager: NSObject, AVAudioRecorderDelegate, SFSpeechRecognizerDelegate {
    var audioRecorder: AVAudioRecorder!
    var speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioEngine = AVAudioEngine()
    
    var timer: Timer?
    var onVolumeUpdate: ((Float) -> Void)?
    var onTextUpdate: ((String) -> Void)? // Callback for recognized text
    
    override init() {
        super.init()
        requestMicrophonePermission()
        requestSpeechRecognitionPermission()
    }
    
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                self.setupRecorder()
            } else {
                print("Microphone permission denied")
            }
        }
    }
    
    func requestSpeechRecognitionPermission() {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Speech recognition authorized.")
            case .denied, .restricted, .notDetermined:
                print("Speech recognition not available.")
            @unknown default:
                break
            }
        }
    }
    
    func setupRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        try? audioSession.setActive(true)
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        let url = URL(fileURLWithPath: "/dev/null") // Discard recording
        audioRecorder = try? AVAudioRecorder(url: url, settings: settings)
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        // 🎤 Capture volume levels every 0.05s
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.audioRecorder.updateMeters()
            let level = pow(10, self.audioRecorder.averagePower(forChannel: 0) / 20) // Convert to linear scale
            self.onVolumeUpdate?(level)
        }
        
        startSpeechRecognition()
    }
    
    func startSpeechRecognition() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!) { result, error in
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                self.onTextUpdate?(bestString) // Update UI with recognized text
            }
            if error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
    }
}
