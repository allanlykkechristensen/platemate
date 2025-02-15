//
//  PercentageSelector.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Foundation

public extension NumberFormatter {
    
    static let intensityFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    static let loadFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    func string(from obj: Double, missing: String = "") -> String {
        string(from: NSNumber(value: obj)) ?? missing
    }

    func string(from obj: Int, missing: String = "") -> String {
        string(from: NSNumber(value: obj)) ?? missing
    }
}
