//
//  OneRepMaxFormula.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Foundation

/// Defines a strategy for calculating One Rep Max (1RM)
protocol OneRepMaxFormula {
    var name: String { get }
    func calculate1RM(weight: Double, reps: Int) -> Double
}

/// Epley Formula Implementation
struct EpleyFormula: OneRepMaxFormula {
    let name = "Epley"
    
    func calculate1RM(weight: Double, reps: Int) -> Double {
        guard reps > 0 else { return weight }
        return weight * (1 + (Double(reps) / 30))
    }
}

/// Brzycki Formula Implementation
struct BrzyckiFormula: OneRepMaxFormula {
    let name = "Brzycki"
    
    func calculate1RM(weight: Double, reps: Int) -> Double {
        guard reps > 0 else { return weight }
        return weight * (36 / (37 - Double(reps)))
    }
}

/// Lander Formula Implementation
struct LanderFormula: OneRepMaxFormula {
    let name = "Lander"
    
    func calculate1RM(weight: Double, reps: Int) -> Double {
        guard reps > 0 else { return weight }
        return (100 * weight) / (101.3 - 2.67123 * Double(reps))
    }
}

/// Lombardi Formula Implementation
struct LombardiFormula: OneRepMaxFormula {
    let name = "Lombardi"
    
    func calculate1RM(weight: Double, reps: Int) -> Double {
        guard reps > 0 else { return weight }
        return weight * pow(Double(reps), 0.1)
    }
}
