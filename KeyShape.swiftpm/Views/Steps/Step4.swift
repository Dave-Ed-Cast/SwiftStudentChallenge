//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 21/02/25.
//

import SwiftUI
import AVKit

struct Step4: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var animationCompleted = false
    @State private var player: AVQueuePlayer?
    @State private var looper: AVPlayerLooper?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("There are infinite possibilities such as: ")
                TypewriterText(
                    fullText: "W#-cv&4e",
                    animationCompleted: $animationCompleted
                )
            }
            .font(.title)
            .padding()
            
            TransparentVideoPlayer(videoName: colorScheme == .dark ? "VideoDark" : "VideoLight")
                .scaledToFill()
                .frame(width: deviceWidth * 0.975, height: deviceOrientation.isPortrait ? deviceHeight * 0.3 : deviceHeight * 0.45)
                .allowsHitTesting(false)
                .accessibilityHint("Imagine a square drawn on a keyboard, however you wish it. If you use your hand and press each button in sequence, you will get a password.")
            
            Spacer()
        }
        
        .onAppear {
            setupPlayer()
        }
        
        
    }
    private func setupPlayer() {
        let videoName = colorScheme == .dark ? "VideoDark" : "VideoLight"
        
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mov") else { return }
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        
        let looper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        queuePlayer.isMuted = true
        queuePlayer.play()
        
        self.player = queuePlayer
        self.looper = looper
        
    }
}

#Preview {
    Step4()
}
