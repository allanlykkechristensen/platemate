//
//  WarmUpSchemaSet.swift
//  Plate Mate
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import Foundation
import SwiftData

@Model
final class WarmUpSchemaSet {
    
    @Attribute(.unique) var id: UUID
    var order: Int
    var reps : Int
    var percentageOfWorkingLoad: Double
    var fixedLoad: Double
    var warmUpSchema: WarmUpSchema?

    init(id: UUID = .init(), order: Int = 0, reps: Int = 0, fixedLoad: Double = 0.0,  percentageOfWorkingLoad: Double = 0.0) {
        self.id = id
        self.order = order
        self.reps = reps
        self.fixedLoad = fixedLoad
        self.percentageOfWorkingLoad = percentageOfWorkingLoad
    }
}
