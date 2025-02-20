//
//  ViewExtension.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    var deviceOrientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }
}
