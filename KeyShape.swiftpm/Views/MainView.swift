//
//  MainView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var view: Navigation
    @EnvironmentObject private var methodHolder: MethodHolder
    
    @State private var currentStep: Int = 0
    @State private var phase: CGFloat = 0
    @State private var hand: String = "none"
    @State private var shape: ShapeView.ShapeType = .unknown
    @State private var text = ""
    @State private var goNext = false
    
    private let lastStep = Steps.stepsArray.count
    
    private var isButtonDisabled: Bool {
        switch currentStep {
        case 0:
            return shape == .unknown
        case 1:
            return hand == "none"
        case 4:
            return !isValidPassword(text)
        default:
            return false
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                StepNamesView(currentStep: currentStep)
                    .frame(height: deviceHeight * 0.07)
                
                
                if currentStep >= lastStep - 3 {
                    Spacer()
                }
                switch currentStep {
                case 0:
                    Step1(chosenShape: $shape)
                case 1:
                    Step2(hand: $hand)
                case 2:
                    Step3(shape: $shape)
                case 3:
                    Step4()
                case 4:
                    Step5(shape: $shape, hand: $hand)
                    TextField("Create your password here...", text: $text)
                        .contentShape(Rectangle())
                        .padding()
                        .frame(width: deviceWidth * 0.35, height: deviceHeight * 0.05)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
                        .onChange(of: text) { newValue in
                            if newValue.count > 30 {
                                text = String(newValue.prefix(30))
                            }
                        }
                        .padding(.horizontal)
                    Spacer()
                    
                case 5:
                    Step6()
                    Spacer()
                default:
                    EmptyView()
                }
            }
            
            .multilineTextAlignment(.center)
            
            Spacer()
            
            
            Button {
                if currentStep < Steps.stepsArray.count - 1 {
                    withAnimation {
                        currentStep += 1
                    }
                } else {
                    withAnimation {
                        goNext = true
                        methodHolder.addShape(side: hand, shapeType: shape)
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                    Text(isButtonDisabled ? "Choose..." : "Next!")
                        .accessibilityHint(isButtonDisabled ? "Interact with the interface first before pressing this button" : "")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .frame(width: buttonWidth, height: buttonHeight)
            }
            .navigationDestination(isPresented: $goNext) {
                MethodListView().navigationBarBackButtonHidden(true)
            }
            
            
            .onChange(of: currentStep) { newValue in
                print(currentStep)
            }
            .disabled(isButtonDisabled)
            .opacity(isButtonDisabled ? 0.5 : 1)
            
        }
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
}

#Preview {
    let methodHolder = MethodHolder()
    
    methodHolder.shapes = [
//        ShapeEntry(id: UUID(), side: "left", shapeType: .circle, name: "default")
        
    ]
    
    return MainView()
        .environmentObject(methodHolder)
}
