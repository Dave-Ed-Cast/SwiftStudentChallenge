//
//  ParentView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct ParentView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var audioManager: AudioManager = .init()
    
    @State private var audioNotRequired = true

    var body: some View {
        ZStack {
            switch navigation.value {
            case .createPassword:
                MainView(audioRequired: audioManager.audioRequired)
                    .environmentObject(navigation)
            case .reload:
                ReloadMainView()
                    .environmentObject(navigation)
            }
        }
    }
}
