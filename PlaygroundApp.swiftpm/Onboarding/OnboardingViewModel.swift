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
            
            let portrait = deviceOrientation.isPortrait
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
                            onboardingComplete = true
                        } label: {
                            Text("Start!")
                                .font(.title3)
                                .frame(
                                    width: portrait ? deviceWidth * 0.15 : deviceWidth * 0.2,
                                    height: portrait ? deviceHeight * 0.05 : deviceHeight * 0.075
                                )
                        }
                        .buttonStyle(.bordered)
                        .offset(y: portrait ? deviceHeight * 0.08 : deviceHeight * 0.15)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    OnboardingViewModel(onboardingComplete: .constant(false), title: "naaaaa", bodyText: "ajjj", showDoneButton: true)
}
