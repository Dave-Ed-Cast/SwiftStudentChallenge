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
                        title: "The concept of password strength",
                        bodyText: "Automatic generated passwords are good! They are strong, memorable one blends uppercase, lowercase, numbers, and symbols (at least 10 characters)."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "Why would I need this?",
                        bodyText: "Face ID/Touch ID is convenient, but what if it doesn't work? Complex passwords can be tough to remember. To make this work better we are going to ask for you to interact with your voice for different steps."
                    )
                    OnboardingViewModel(
                        onboardingComplete: $onboarding.completed,
                        title: "The best experience",
                        bodyText: "Works on all keyboards, but an external one helps adapt your password to every occasion! ",
                        showDoneButton: true
                    )
                }
                .environmentObject(onboarding)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .conditionalModifier(welcomeShouldGoUp) {
            $0.overlay(alignment: .topTrailing) {
                Button {
                    withAnimation {
                        onboarding.skip()
                    }
                } label: {
                    Text("Skip")
                }
                .buttonBorderShape(.automatic)
                .padding()
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
