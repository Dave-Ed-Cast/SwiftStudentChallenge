//
//  TransparentVideoPlayer.swift
//  KeyShape
//
//  Created by Davide Castaldi on 21/02/25.
//

import SwiftUI
import AVKit

struct TransparentVideoPlayer: UIViewControllerRepresentable {
    let videoName: String
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let url = Bundle.main.url(
            forResource: videoName,
            withExtension: "mov"
        )!
        
        let player = AVPlayer(url: url)
        
        controller.player = player
        controller.view.backgroundColor = .clear
        controller.view.sizeThatFits(.init(width: deviceWidth * 0.9, height: deviceHeight * 0.3))
        controller.modalPresentationStyle = .overFullScreen
        
        player.isMuted = true
        player.play()
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
