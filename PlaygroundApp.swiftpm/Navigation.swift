//
//  NavigationValue.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

enum NavigationValue {
    case createPassword
    case reward
}

class Navigation: ObservableObject {
    static var shared = Navigation()
    @Published public var value: NavigationValue = .createPassword
    private init() {}
}
