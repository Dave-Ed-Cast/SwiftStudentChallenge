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
    
    var body: some View {
        ZStack {
            switch navigation.value {
            case .list:
                NavigationStack {
                    MethodListView()
                        .transition(.move(edge: .trailing))
                }
                .environmentObject(navigation)
                .environmentObject(methodHolder)
            case .createPassword:
                NavigationStack {
                    MainView()
                        .transition(.move(edge: .leading))
                }
                .environmentObject(navigation)
                .environmentObject(methodHolder)
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
