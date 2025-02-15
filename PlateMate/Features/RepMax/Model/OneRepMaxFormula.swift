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
    func calculateLoad(forRepMax: Int, repsCompleted: Int, loadLifted: Double) -> Double
}

/// Epley Formula Implementation
struct EpleyFormula: OneRepMaxFormula {
    let name = "Epley"

    public func calculateLoad(forRepMax: Int, repsCompleted: Int, loadLifted: Double) -> Double {
        guard repsCompleted > 0 else { return loadLifted }

        var oneRepMax = loadLifted
        if repsCompleted != 1 {
            oneRepMax = loadLifted * (1.0 + Double(repsCompleted) / 30)
        }

        if forRepMax == 1 {
            return oneRepMax
        } else {
            return oneRepMax * (1.0 - 0.0333 * Double(forRepMax))
        }
    }
}

/// Brzycki Formula Implementation
struct BrzyckiFormula: OneRepMaxFormula {
    let name = "Brzycki"

    public func calculateLoad(forRepMax: Int, repsCompleted: Int, loadLifted: Double) -> Double {
        guard repsCompleted > 0, repsCompleted < 37 else { return loadLifted }

        let oneRepMax = loadLifted * (36 / (37 - Double(repsCompleted)))

        if forRepMax == 1 {
            return oneRepMax
        } else {
            return oneRepMax * ((37 - Double(forRepMax)) / 36)
        }
    }
}

/// Lander Formula Implementation
struct LanderFormula: OneRepMaxFormula {
    let name = "Lander"

    public func calculateLoad(forRepMax: Int, repsCompleted: Int, loadLifted: Double) -> Double {
        guard repsCompleted > 0 else { return loadLifted }

        let oneRepMax = (100 * loadLifted) / (101.3 - (2.67123 * Double(repsCompleted)))

        if forRepMax == 1 {
            return oneRepMax
        } else {
            return (oneRepMax * (101.3 - (2.67123 * Double(forRepMax)))) / 100
        }
    }
}

/// Lombardi Formula Implementation
struct LombardiFormula: OneRepMaxFormula {
    let name = "Lombardi"

    public func calculateLoad(forRepMax: Int, repsCompleted: Int, loadLifted: Double) -> Double {
        guard repsCompleted > 0 else { return loadLifted }

        let oneRepMax = loadLifted * pow(Double(repsCompleted), 0.1)

        if forRepMax == 1 {
            return oneRepMax
        } else {
            return oneRepMax / pow(Double(forRepMax), 0.1)
        }
    }
}

/// Formula Factory for Retrieving Formulas
struct FormulaFactory {
    static let formulas: [OneRepMaxFormula] = [
        EpleyFormula(),
        BrzyckiFormula(),
        LanderFormula(),
        LombardiFormula()
    ]

    static func formula(named name: String) -> OneRepMaxFormula {
        return formulas.first(where: { $0.name == name }) ?? EpleyFormula()
    }
}
