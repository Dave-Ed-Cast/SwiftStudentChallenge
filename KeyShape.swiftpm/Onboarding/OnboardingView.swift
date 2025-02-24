//
//  OnboardingView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var onboarding: Onboarding
    
    @State private var offsetY: CGFloat = 0
    @State private var welcomeShouldGoUp = false
    
    let size = UIScreen.main.bounds.size
    @Namespace var namespace
    
    var body: some View {
        VStack {
            Spacer()
            AnimatedWelcome(namespace: namespace)
                .offset(y: offsetY)
                .onAppear {
                    
                    withAnimation(.bouncy(duration: 1).delay(3)) {
                        welcomeShouldGoUp = true
                    }
                }
            
            Spacer()
            
            if welcomeShouldGoUp {
                TabView {
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "What is KeyShape?",
                        bodyText: "A password is a key to a secret vault. The stronger it is, the safer your treasures remain. That's why it must be impossible to guess! With KeyShape, your password will be safe and easy to remember."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Meet your internal key",
                        bodyText: "Face ID/Touch ID are useful. However, they might fail or you might need to access an account that doesn't have the password saved. Wouldn't you like your key to be in the safest place ever? With KeyShape, your key will always be inside you."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "How do I build this?",
                        bodyText: "KeyShape will use primitive and instintive techniques to build your key. It will be a fun and interactive process! Let’s build one that conforms to today's standards together, shall we?",
                        showDoneButton: true
                    )
                }
                .environmentObject(onboarding)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .padding()
        .onDisappear {
            if onboarding.completed {
                withAnimation {
                    onboarding.saveCompletionValue()
                }
            }
        }
    }
}

#Preview {
    OnboardingView(onboarding: .init())
}
