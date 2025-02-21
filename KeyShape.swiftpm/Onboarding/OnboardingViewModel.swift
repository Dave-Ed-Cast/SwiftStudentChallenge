//
//  OnboardingViewModel.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct OnboardingViewModel: View {
    
    @Binding var onboardingComplete: Bool
    @EnvironmentObject private var onboarding: Onboarding
    
    let title: String
    let bodyText: String
    var showDoneButton: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(bodyText)
                .font(.title2)
                .frame(height: deviceHeight * 0.15)
                .multilineTextAlignment(.center)
                .if(showDoneButton) {
                    $0.overlay(alignment: .bottom) {
                        Button {
                            withAnimation(.easeIn(duration: 0.5)) {
                                onboardingComplete = true
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                Text("Start!")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    
                            }
                            .frame(width: buttonWidth, height: buttonHeight)
                        }
                        
                        .offset(y: deviceOrientation.isPortrait ? deviceHeight * 0.08 : deviceHeight * 0.15)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    OnboardingViewModel(onboardingComplete: .constant(false), title: "naaaaa", bodyText: "ajjj", showDoneButton: true)
}
