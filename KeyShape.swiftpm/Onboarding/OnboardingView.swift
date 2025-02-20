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
                    
                    withAnimation(.bouncy(duration: 1).delay(1.5)) {
                        welcomeShouldGoUp = true
                    }
                }
            
            Spacer()
            
            if welcomeShouldGoUp {
                TabView {
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Meet your digital key",
                        bodyText: "Imagine your password as a key to a secret vault. The stronger, the safer your treasures remain. A great key is unique! With KeyShape, your password will be easy to remember and safe."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "What if your key gets stuck?",
                        bodyText: "Face ID/Touch ID are magic doors, fast and seamless. However, they might failt and you need to use your key. With KeyShape you won't need To make remember with much effort your key."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Tailor your key for every door",
                        bodyText: "A master key opens every door, so does a well designed password to any keyboard. Let’s build one that blends letters, numbers, and symbols effortlessly. Ready to secure your digital world? Let’s do it!",
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
                onboarding.saveCompletionValue()
            }
        }
        .frame(width: deviceWidth * 0.9)
    }
}

#Preview {
    OnboardingView(onboarding: .init())
}
