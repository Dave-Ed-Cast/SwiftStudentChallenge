//
//  CreatePassword.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentStep: Int = 0
    @State private var phase: CGFloat = 0
    @State private var keyboardChoice: String = "none"
    @State private var recognizedText: String = "Say something..."

    let stepName = Steps.stepsArray
    let stepDescription = Steps.descriptionArray
    
    var body: some View {
        VStack {
            let disabled = (currentStep == 3 && keyboardChoice == "none")

            VStack(spacing: 30) {
                Text(stepName[currentStep])
                    .font(.largeTitle)
                Text(stepDescription[currentStep])
                    .font(.title2)
                
                Text(recognizedText)
                    .font(.headline)
                
                switch currentStep {
                case 0:
                    Step1()
                case 1:
                    Step2()
                case 2:
                    Step3()
                case 3:
                    Step4(keyboardChoice: $keyboardChoice)
                case 4:
                    Step5(keyboardChoice: $keyboardChoice)
                case 5:
                    Step6()
                case 6:
                    Step7()
                case 7:
                    Circle()
                        .frame(width: 200, height: 200)
                default:
                    EmptyView()
                }
            }
            .multilineTextAlignment(.center)
            
//            SineWaveShape(phase: phase)
//                .stroke(Color.blue, lineWidth: 6)
//                .scaleEffect(1.1)
            MetalSineWaveView()
            
            Button {
                if currentStep < Steps.stepsArray.count {
                    currentStep += 1
                    withAnimation(.easeOut(duration: 2)) {
                        phase += 100
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                    Text(disabled ? "Choose..." : "Next!")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .frame(width: deviceWidth * 0.2, height: deviceHeight * 0.075)
            }
            .disabled(disabled)
            .opacity(disabled ? 0.5 : 1)
        }
        .onAppear {
            let audioManager = AudioManager()
            audioManager.onTextUpdate = { text in
                DispatchQueue.main.async {
                    if let lastWord = text.split(separator: " ").last {
                        self.recognizedText = String(lastWord)
                    }
                }
            }
        }
        .onChange(of: recognizedText) { newValue in
            recognizedText = ""
            recognizedText = newValue
        }
        .padding()
    }
}
