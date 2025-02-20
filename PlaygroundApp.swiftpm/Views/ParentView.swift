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
    @StateObject private var methodHolder: MethodHolder = .init()
    
    @State private var audioNotRequired = true

    var body: some View {
        ZStack {
            switch navigation.value {
                
            case .list:
                MethodListView()
                    .environmentObject(navigation)
                    .environmentObject(methodHolder)
                
            case .createPassword:
                MainView(audioRequired: audioManager.audioRequired)
                    .environmentObject(navigation)
                    .environmentObject(methodHolder)
                    .environmentObject(audioManager)
            }
        }
        .onAppear {
            methodHolder.loadFromJSON() // Ensure data is loaded before checking
                if methodHolder.shapes.isEmpty {
                    print("had to go to creation!")
                    navigation.value = .createPassword
                } else {
                    print("went to list!")
                    navigation.value = .list
                }
            
        }
    }
}
