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

/// Calculate RM or Rep Max indicators for your lifts. Provide the class with a data point when
/// initializing and use the public functions to calculate the RM indicators.
public struct RepMaxCalculator {

    public let dataPointReps: Int
    public let dataPointLoad: Double
    private let weightPlateIncrement: Double

    let repMaxFormula: OneRepMaxFormula

    /// True if rm1 is estimated based on the data points, or false if ``rm1`` is actually a one-rep-max.
    public let estimatedRm1: Bool

    /// Calculated property containing the 1RM load based on the data point provided in the initializer.
    public var rm1: Double {
        return calculateRepMaxLoad(reps: 1)
    }

    /// Initializes the RepMax class with a data point of a lift.
    ///
    /// - Parameters:
    ///   - reps: Number of repetitions.
    ///   - load: Load of each repetition.
    ///   - increment: Weight plate increment used for calculating a new rep max.
    init(reps: Int, load: Double, increment: Double = 2.5, with formula: OneRepMaxFormula = EpleyFormula()) {
        self.dataPointReps = reps
        self.dataPointLoad = load
        self.weightPlateIncrement = increment
        self.estimatedRm1 = (self.dataPointReps != 1)
        self.repMaxFormula = formula
    }

    /// Based on the data point provided during initialization, this function calculates the load of another rep max.
    ///
    /// - Parameter reps: Rep max to calculate.
    /// - Parameter intensity: Intensity of the Rep Max, default is 1.0 (100%)
    /// - Returns: Load for the given reps.
    public func calculateRepMaxLoad(reps: Int, intensity: Double = 1.0) -> Double {
        if reps == dataPointReps {
            return dataPointLoad
        }

        let estimatedRepMax = repMaxFormula.calculateLoad(
            forRepMax: reps,
            repsCompleted: dataPointReps,
            loadLifted: dataPointLoad)

        let roundedEstimate = (estimatedRepMax*intensity).roundToIncrement(increment: weightPlateIncrement)
        return roundedEstimate
    }

    /// Calculates the intensity of a lift relative to the data point provided during initialization.
    ///
    /// - Parameters:
    ///   - reps: Number of repetitions.
    ///   - load: Load of each repetition.
    /// - Returns: Intensity of the given lift relatative to the data point provided during initialization.
    public func calculateIntensity(reps: Int, load: Double) -> Double {
        let repMax = RepMaxCalculator(reps: reps, load: load)
        let intensity = repMax.rm1/self.rm1
        if intensity.isInfinite {
            return 1.0
        } else {
            return intensity
        }
    }

    /// Calculates the intensity of a lift relative to 1RM.
    ///
    /// - Parameters:
    ///   - reps: Number of repetitions.
    /// - Returns: Intensity of the given lift relatative to the data point provided during initialization.
    public func calculateIntensity(reps: Int) -> Double {
        if reps == 0 {
            return 0.0
        }

        let load = calculateRepMaxLoad(reps: reps)
        let intensity = load/self.rm1
        if intensity.isInfinite || intensity.isNaN {
            return 1.0
        } else {
            return round(intensity*100)/100
        }
    }

    /// Calculates the load for a specific in intensity of 1RM.
    ///
    /// - Parameters:
    ///   - intensity: Percent of 1RM
    /// - Returns: Load of 1RM * intensity
    public func calculateLoad(intensity: Double) -> Double {
        if intensity == 1.0 {
            return dataPointLoad
        }

        let load = self.rm1 * intensity
        let roundedLoad = ceil(load/weightPlateIncrement) * weightPlateIncrement

        if roundedLoad.isInfinite || roundedLoad.isNaN {
            return 0.0
        } else {
            return roundedLoad
        }
    }

    public func calculateLoad(intensityType: IntensityType, reps: Int) -> Double {
        var maxReps = 0
        switch intensityType {
        case .rir(let rir):
            maxReps = reps + Int(rir)
        case .rpe(let rpe):
            maxReps = reps + (10-Int(rpe))
        default:
            maxReps = reps
        }
        return calculateRepMaxLoad(reps: maxReps)
    }
}
