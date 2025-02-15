//
//  IntensityType.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Foundation

public enum IntensityType: Equatable {
    case manual
    case percentageOneRepMax(percentage: Double)
    case rpe(rpe: Double)
    case rir(rir: Double)
}
