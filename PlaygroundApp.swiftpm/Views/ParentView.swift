//
//  NavigationValue 2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct ParentView: View {
    
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ZStack {
            switch navigation.value {
            case .createPassword:
                MainView()
                    .environmentObject(navigation)
            }
        }
    }
}
