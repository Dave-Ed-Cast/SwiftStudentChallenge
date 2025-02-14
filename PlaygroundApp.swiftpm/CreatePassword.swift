//
//  CreatePassword.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct CreatePassword: View {
    
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: Int = 0
    @State private var phase: CGFloat = 0
    
    @State private var showReward: Bool = false
    @State private var yetToShowImages: Bool = true
        
    let totalSteps = 5
    
    let stepsArray = [
        "Step 1: Secure the key",
        "Step 2: Ascend from darkness",
        "Step 3: Rain fire",
        "Step 4: Unleash the creativity",
        "Step 5: Skewer the winged beast",
        "Step 6: Wield an iron fist",
        "Step 7: Raise Hell",
        "Step 8: Freedom (from technology)"
    ]
    
    let descriptionArray = [
        "With what shape you synergize the most? Choose carefully as this will be the core. After that, press the button.",
        "Do you wish to join multiple shapes? We suggest to keep it simple for starters",
        "It is now time to understand if you like to use one hand or two hands",
        "Choose your hand(s) and define your dynamics. While based on QWERTY iPad keyboard, any keyboard and layout works. Here are tips to help.",
        "R",
        "A",
        "Ab",
        "Ac"
    ]
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text(stepsArray[currentStep])
                    .font(.largeTitle)
                Text(descriptionArray[currentStep])
                    .font(.title3)
                
                switch currentStep {
                case 0:
                    ShapeTransitionView(shapeIndex: 0)
                case 1:
                    HStack {
                        ShapeTransitionView(shapeIndex: 0)
                        ShapeTransitionView(shapeIndex: 2)
                    }
                    .onAppear {
                        Task {
                            try? await Task.sleep(nanoseconds: 2_000_000_000)
                        }
                    }
                case 2:
                    Circle()
                        .frame(width: 200, height: 200)
                case 3:
                    VStack {
                        if yetToShowImages {
                            VStack {
                                Text("Which keyboard are you using? So we can guide you better.")
                                HStack {
                                    Button {
                                        
                                    } label: {
                                       Text("External/Mac keyboard")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("iPad native")
                                    }
                                    
                                }
                            }
                        }
                        Image("Keyboard")
                            .frame(width: deviceWidth * 0.8)
                        VStack {
                            Text("Look at the keyboard and choose with the corresponding preference.")
                            Text("**Left hand?** Focus on the left side.")
                            Text("**Right hand?** Stick to the right.")
                            Text("**Mixed password?** Use both hands.")
                        }
                        .font(.headline)
                        .padding()
                    }
                case 4:
                    Circle()
                        .frame(width: 200, height: 200)
                case 5:
                    Circle()
                        .frame(width: 200, height: 200)
                case 6:
                    Circle()
                        .frame(width: 200, height: 200)
                case 7:
                    Circle()
                        .frame(width: 200, height: 200)
                default:
                    EmptyView()
                }
            }
            .multilineTextAlignment(.center)
            
            SineWaveShape(phase: phase)
                .stroke(Color.blue, lineWidth: 6)
                .scaleEffect(1.1)
                .onAppear {
                    withAnimation(.spring(dampingFraction: 5.0, blendDuration: 10.0)) {
                        phase -= 50
                    }
                    
                }
            
            Button {
                if currentStep < stepsArray.count {
                    currentStep += 1
                    withAnimation(.easeOut(duration: 3)) {
                        phase -= 100
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                    Text("Next!")
                        .foregroundStyle(.white)
                        .font(.title2)
                }
                .frame(width: deviceWidth * 0.2, height: deviceHeight * 0.075)
            }
        }
        .animation(.easeInOut, value: currentStep)
        .padding()
    }
}
