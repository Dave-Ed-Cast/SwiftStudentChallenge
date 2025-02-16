//
//  CreatePassword.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct MainView: View {
        
    @State private var currentStep: Int = 0
    @State private var phase: CGFloat = 0
    @State private var keyboardChoice: String = "none"

    let stepName = Steps.stepsArray
    let stepDescription = Steps.descriptionArray
    
    var body: some View {
        VStack {
            let disabled = (currentStep == 3 && keyboardChoice == "none")

            VStack(spacing: 30) {
                Text(stepName[currentStep])
                    .font(.largeTitle)
                Text(stepDescription[currentStep])
                    .font(.title2)
                
                switch currentStep {
                case 0:
                    Step1()
                case 1:
                    Step2()
                case 2:
                    Step3(keyboardChoice: $keyboardChoice)
                case 3:
                    Step4(keyboardChoice: $keyboardChoice)
                case 4:
                    Step5()
                case 5:
                    Step6()
                default:
                    EmptyView()
                }
            }
            .multilineTextAlignment(.center)
            
            MetalSineWaveView()

            Button {
                if currentStep < Steps.stepsArray.count {
                    currentStep += 1
                    withAnimation(.easeOut(duration: 2)) {
                        phase += 100
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                    Text(disabled ? "Choose..." : "Next!")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .frame(width: deviceWidth * 0.2, height: deviceHeight * 0.075)
            }
            .disabled(disabled)
            .opacity(disabled ? 0.5 : 1)
        }
        
        .padding()
    }
}
