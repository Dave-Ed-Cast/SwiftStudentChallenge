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
        "Wazxdew",
        "Tfvbhy",
        "Ijm,lo"
    ]
    
    private let triangleCombinations: [String] = [
        "Eszxcde",
        "Ygvbnmjy",
        "Okm,.lo"
    ]
    
    private let squareCombinations: [String] = [
        "Wqazxcdew",
        "Tgbnmjuy",
        "Ujm,.loi"
    ]
    
    private var chosenShape: ShapeView.ShapeType
    private var task: Task<Void, Never>?  // Store and cancel cycling
    
    init(chosenShape: ShapeView.ShapeType = .circle) {
        self.chosenShape = chosenShape
        self.currentPassword = requiredPasswords().first ?? ""
        Task {
            try? await Task.sleep(for: .seconds(2.5)) 
            startCycling()
        }
    }
    
    /// Starts cycling passwords every 2.5 seconds, ensuring only one cycle runs at a time.
    func startCycling() {
        task?.cancel() // Cancel any existing task
        
        task = Task {
            let passwords = requiredPasswords()
            
            while !Task.isCancelled {
                await MainActor.run {
                    self.currentIndex = (self.currentIndex + 1) % passwords.count
                    self.currentPassword = passwords[self.currentIndex]
                }
                try? await Task.sleep(nanoseconds: 2_500_000_000) // Sleep for 2.5 seconds
            }
        }
    }
    
    /// Updates the shape and resets cycling, ensuring previous cycles stop before restarting.
    func updateShape(to newShape: ShapeView.ShapeType) {
        if newShape != chosenShape {
            task?.cancel() // Stop current cycle before changing shape
            chosenShape = newShape
            currentIndex = 0 // Reset index
            currentPassword = requiredPasswords().first ?? ""
            startCycling() // Restart cycling with new passwords
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

#Preview {
    Step3(shape: .constant(.circle))
}
