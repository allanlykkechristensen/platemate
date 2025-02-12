//
//  ActualWarmUpSet.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import Foundation

public struct ActualWarmUpSet: Equatable, Identifiable {
    public let id = UUID().uuidString
    public let reps: Int
    public let load: Double
    public let percent: Double
    
    public init(reps: Int, load: Double, percent: Double) {
        self.reps = reps
        self.load = load
        self.percent = percent
    }
}
