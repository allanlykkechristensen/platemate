//
//  Double+RoundToIncrement.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Foundation

extension Double {

    func roundToIncrement(increment: Double) -> Double {
        return ceil((self)/increment) * increment
    }

}
