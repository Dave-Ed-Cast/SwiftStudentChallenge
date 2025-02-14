//
//  NavigationValue 2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct ParentView: View {
    
    @EnvironmentObject private var view: Navigation
    
    var body: some View {
        ZStack {
            switch view.value {
            case .createPassword:
                CreatePassword()
            case .reward:
                RewardView()
            }
        }
    }
}
