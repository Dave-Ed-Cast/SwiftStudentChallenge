//
//  SwiftUIView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import SwiftUI

struct ReloadMainView: View {
    
    @EnvironmentObject var view: Navigation
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    ReloadMainView()
}
