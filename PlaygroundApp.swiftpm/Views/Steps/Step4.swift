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
    
    var body: some View {
        Group {
            if choosingImages {
                HStack(spacing: 10) {
                    Button {
                        keyboardChoice = "Traditional"
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
                        showNativeKeyboard = true
                    } label: {
                        VStack {
                            Image("Native")
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .padding()
                            Text("iPad Native keyboard")
                                .offset(y: deviceOrientation.isPortrait ? deviceHeight * 0.009 : 0)
                        }
                    }
                }
                .frame(width: deviceWidth * 0.75)
            }
        }
        
        .onDisappear {
            choosingImages = false
        }
    }
}
#Preview {
    Step4(keyboardChoice: .constant("Traditional"))
}
