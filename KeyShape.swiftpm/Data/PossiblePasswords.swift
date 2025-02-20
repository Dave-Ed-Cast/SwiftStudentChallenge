//
//  PossiblePassowrds.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import SwiftUI

class PossiblePasswords: ObservableObject {
    
    @Published private var currentIndex: Int = 0
    @Published var currentPassword: String = ""
    
    private let circleCombinations: [String] = [
        "Esxcfre",
        "Tfvbhy",
        "Ijm,lo"
    ]
    
    private let triangleCombinations: [String] = [
        "Eszxcde",
        "Tfcvbgt",
        "Ijnm,ku"
    ]
    
    private let squareCombinations: [String] = [
        "Wsxcvfre",
        "Rfvbnhyt",
        "Ujm,.loi"
    ]
    
    private var chosenShape: ShapeView.ShapeType
    private var task: Task<Void, Never>?
    
    init(chosenShape: ShapeView.ShapeType = .circle) {
        self.chosenShape = chosenShape
        self.currentPassword = requiredPasswords().first ?? ""
    }
    
    func startCycling() {
        task?.cancel()
        
        task = Task {
            let passwords = requiredPasswords()
            
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(2.5))
                await MainActor.run {
                    self.currentIndex = (self.currentIndex + 1) % passwords.count
                    self.currentPassword = passwords[self.currentIndex]
                }
                
            }
        }
    }
    
    func updateShape(to newShape: ShapeView.ShapeType) {
        if newShape != chosenShape {
            task?.cancel()
            chosenShape = newShape
            currentIndex = 0
            currentPassword = requiredPasswords().first ?? ""
            startCycling()
        }
    }
    
    private func requiredPasswords() -> [String] {
        switch chosenShape {
        case .circle:
            return circleCombinations
        case .triangle:
            return triangleCombinations
        case .square:
            return squareCombinations
        case .unknown:
            return [""]
        }
    }
}

#Preview("triangle") {
    Step3(shape: .constant(.triangle))
}

#Preview("square") {
    Step3(shape: .constant(.square))
}

#Preview("circle") {
    Step3(shape: .constant(.circle))
}
