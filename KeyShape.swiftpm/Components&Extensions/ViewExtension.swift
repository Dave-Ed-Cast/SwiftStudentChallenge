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
    
    var buttonWidth: CGFloat {
        deviceOrientation.isPortrait ? deviceWidth * 0.275 : deviceWidth * 0.2
    }
    
    var buttonHeight: CGFloat {
        deviceOrientation.isPortrait ? deviceHeight * 0.045 : deviceHeight * 0.075
    }
}
