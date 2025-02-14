//
//  AnimatedWelcome.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var navigation = Navigation.shared
    @StateObject private var onboarding: Onboarding = .init()
    
    var body: some Scene {
        WindowGroup {
            if onboarding.completed || onboarding.skipped {
                ParentView()
                    .environmentObject(navigation)
                    .environmentObject(onboarding)
            } else {
                OnboardingView(onboarding: onboarding)
                    .environmentObject(navigation)
            }
            
        }
    }
}
