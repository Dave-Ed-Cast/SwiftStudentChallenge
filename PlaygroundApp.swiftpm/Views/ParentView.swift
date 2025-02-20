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
    @StateObject private var metodHolder: MethodHolder = .init()
    
    @State private var audioNotRequired = true

    var body: some View {
        ZStack {
            switch navigation.value {
            case .list:
                MethodListView()
                    .environmentObject(navigation)
                    .environmentObject(metodHolder)
                
            case .createPassword:
                MainView(audioRequired: audioManager.audioRequired)
                    .environmentObject(navigation)
                    .environmentObject(metodHolder)
                
            }
        }
    }
}
