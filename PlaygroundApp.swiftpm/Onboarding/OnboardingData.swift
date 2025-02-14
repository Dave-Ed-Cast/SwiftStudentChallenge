//
//  OnboardingParameters.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

final class Onboarding: ObservableObject {
    
    @Published var completed: Bool
    @Published var skipped: Bool
    @Published var currentStep: Int
    
    private let onboardingStatusKey = "OnboardingStatus"
    private let onboardingSkippedKey = "OnboardingSkipped"
    
    let config = UserDefaults.standard
    
    init() {
        self.completed = config.bool(forKey: onboardingStatusKey)
        self.skipped = config.bool(forKey: onboardingSkippedKey)
        self.currentStep = 0
    }
    
    func saveCompletionValue() {
        self.completed = true
        config.set(true, forKey: onboardingStatusKey)
    }
    
    func skip() {
        self.skipped = true
        config.set(true, forKey: onboardingSkippedKey)
    }
}
