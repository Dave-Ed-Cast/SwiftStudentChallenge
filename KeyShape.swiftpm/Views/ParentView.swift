//
//  ParentView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct ParentView: View {
    
    @EnvironmentObject private var navigation: Navigation
    
    @StateObject private var methodHolder: MethodHolder = .init()
    
    @State private var audioNotRequired = true

    var body: some View {
        ZStack {
            switch navigation.value {
            case .list:
                MethodListView()
                    .environmentObject(navigation)
                    .environmentObject(methodHolder)
                    .transition(.move(edge: .trailing))
            
            case .createPassword:
                MainView()
                    .environmentObject(navigation)
                    .environmentObject(methodHolder)
                    .transition(.move(edge: .leading))
            }
        }
        .onAppear {
            methodHolder.loadFromJSON()
                if methodHolder.shapes.isEmpty {
                    navigation.value = .createPassword
                } else {
                    navigation.value = .list
                }
            
        }
    }
}
