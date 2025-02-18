//
//  CreatePassword.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct MainView: View {
        
    @EnvironmentObject private var view: Navigation
    
    @State private var currentStep: Int = 0
    @State private var phase: CGFloat = 0
    @State private var chosenKeyboard: String = "none"
    @State private var spokenHand: String = "none"
    @State private var spokenShape: ShapeView.ShapeType = .unknown
    @State private var text = ""


    let stepName = Steps.stepsArray
    let stepDescription = Steps.descriptionArray
    
    var isButtonDisabled: Bool {
        switch currentStep {
        case 0:
            return spokenShape == .unknown
        case 1:
            return spokenHand == "none"
        case 2:
            return chosenKeyboard == "none"
        case 4:
            return text == ""
        default:
            return false
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Group {
                    Text(stepName[currentStep])
                        .font(.largeTitle)
                    Text(stepDescription[currentStep])
                        .font(.title2)
                }
                .frame(height: deviceHeight * 0.07)
                if currentStep >= 3 {
                    Spacer()
                }
                switch currentStep {
                case 0:
                    Step1(spokenShape: $spokenShape)
                case 1:
                    Step2(spokenHand: $spokenHand)
                case 2:
                    Step3(chosenKeyboard: $chosenKeyboard)
                case 3:
                    Text("Here is an example:")
                    Step4(
                        keyboardChoice: $chosenKeyboard,
                        spokenShape: $spokenShape
                    )
                    Spacer()
                case 4:
                    Step5(
                        spokenShape: $spokenShape,
                        spokenHand: $spokenHand,
                        keyboardChoice: $chosenKeyboard
                    )
                    TextField("Create your password here...", text: $text)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
                        .frame(width: deviceWidth * 0.35, height: deviceHeight * 0.06)
                        .onChange(of: text) { newValue in
                            if newValue.count > 30 {
                                text = String(newValue.prefix(30))
                            }
                        }
                        .padding()
                    Spacer()
                case 5:
                    Step6()
                    Spacer()
                default:
                    EmptyView()
                }
            }
            
            .multilineTextAlignment(.center)
            
            if currentStep < 3 {
                AudioFeedback()
            }
            
            if currentStep >= 3 {
                Spacer()
            }
            if currentStep < stepName.count {
                Button {
                    if currentStep < Steps.stepsArray.count {
                        currentStep += 1
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue)
                        Text(isButtonDisabled ? "Choose..." : "Next!")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                    .frame(width: deviceWidth * 0.2, height: deviceHeight * 0.075)
                }
                .onChange(of: currentStep) { newValue in
                    print(currentStep)
                }
                .disabled(isButtonDisabled)
                .opacity(isButtonDisabled ? 0.5 : 1)
            } else {
                Button {
                    view.value = .createPassword
                } label: {
                    Text("Try again?")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .frame(width: deviceWidth * 0.2, height: deviceHeight * 0.075)
            }
        }
        
        .padding()
    }
}

#Preview {
    MainView()
}
