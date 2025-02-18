//
//  OnboardingView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var onboarding: Onboarding
    @State private var welcomeShouldGoUp = false
    
    let size = UIScreen.main.bounds.size
    @Namespace var namespace
    
    var body: some View {
        VStack {
            Spacer()
            AnimatedWelcome(namespace: namespace)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.25).delay(1)) {
                        welcomeShouldGoUp = true
                    }
                }
            
            Spacer()
            
            if welcomeShouldGoUp {
                TabView {
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Meet Your Digital Key",
                        bodyText: "Imagine your password as a key to a secret vault. The stronger it is, the safer your treasures (data) stay. A great key isn’t just long, it’s unique! Mobile, external or traditional keyboard? Your password will be easy to remember and still safe."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "What If Your Key Gets Stuck?",
                        bodyText: "Face ID and Touch ID are like magic doors—fast and seamless. But what if they don’t open? A strong password is your backup key, always ready. To make things even smoother, we’ll guide you through a voice-assisted setup."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Tailor Your Key for Every Door",
                        bodyText: "Just like a master key works everywhere, a well designed password adapts to any keyboard. Let’s build one that blends letters, numbers, and symbols effortlessly. Ready to secure your digital world? Let’s do it!",
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
