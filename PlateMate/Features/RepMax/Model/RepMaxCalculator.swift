//
//  RepMaxCalculator.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Foundation

struct RepMax {
    let reps: Int
    let weight: Double
    let intensity: Double  // Intensity as a percentage of 1RM
}

struct RepMaxCalculator {
    let formula: OneRepMaxFormula


    func calculateRepMaxes(from weight: Double, reps: Int, upTo targetMax: Int = 20) -> [RepMax] {
        let oneRM = formula.calculate1RM(weight: weight, reps: reps)

        var repMaxes: [RepMax] = []
        for targetReps in 1...targetMax {
            let repWeight = formula.calculate1RM(weight: oneRM, reps: targetReps)
            let intensity = (repWeight / oneRM) * 100  // Calculate intensity as a percentage
            repMaxes.append(RepMax(reps: targetReps, weight: repWeight, intensity: intensity))
        }

        return repMaxes
    }

}
