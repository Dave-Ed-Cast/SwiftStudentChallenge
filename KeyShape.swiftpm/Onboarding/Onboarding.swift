//
//  Onboarding.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

final class Onboarding: ObservableObject {
    
    @Published var completed: Bool
    @Published var currentStep: Int
    
    private let onboardingStatusKey = "OnboardingStatus"
    
    let config = UserDefaults.standard
    
    init() {
        self.completed = config.bool(forKey: onboardingStatusKey)
        self.currentStep = 0
    }
    
    func saveCompletionValue() {
        self.completed = true
        config.set(true, forKey: onboardingStatusKey)
    }
}
