//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step4: View {
    
    @Binding var keyboardChoice: String

    @State private var choosingImages: Bool = true
    @State private var showTraditionalKeyboard: Bool = false
    @State private var showNativeKeyboard: Bool = false
    
    let config = UserDefaults.standard
    
    var body: some View {
        VStack {
            if choosingImages {
                VStack {
                    Text("Which keyboard are you using? Express your preference so we can guide you better!")
                    HStack(spacing: 10) {
                        Button {
                            keyboardChoice = "Traditional"
                            config.set("Traditional", forKey: "keyboard")
                            showTraditionalKeyboard = true
                        } label: {
                            VStack {
                                Image("Traditional")
                                    .resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .padding()
                                Text("External/Mac keyboard")
                            }
                        }
                        
                        Button {
                            keyboardChoice = "Native"
                            config.set("Native", forKey: "keyboard")
                            showNativeKeyboard = true
                        } label: {
                            VStack(spacing: 8) {
                                Image("Native")
                                    .resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .scaleEffect(x: 1.2, y: 1.4)
                                    .padding()
                                Text("iPad Native keyboard")
                                    .offset(y: deviceHeight * 0.016)
                            }
                        }
                    }
                    .frame(width: deviceWidth * 0.75)
                }
            }
        }
        .onDisappear{
            choosingImages = false
        }
    }
}
#Preview {
    Step4(keyboardChoice: .constant("Traditional"))
}
