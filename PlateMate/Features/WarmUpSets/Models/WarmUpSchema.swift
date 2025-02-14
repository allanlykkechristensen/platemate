//
//  WarmUpSchema.swift
//  Plate Mate
//
//  Created by Allan Lykke Christensen on 11/02/2025.
//

import Foundation
import SwiftData

@Model
final class WarmUpSchema {

    @Attribute(.unique) var id: UUID
    var name: String
    var note: String
    @Relationship(deleteRule: .cascade, inverse: \WarmUpSchemaSet.warmUpSchema)
    var sets: [WarmUpSchemaSet]

    init(id: UUID = .init(), name: String, note: String, sets: [WarmUpSchemaSet] = []) {
        self.id = id
        self.name = name
        self.note = note
        self.sets = sets
    }

    func calculate(workingLoad: Double, weightIncrement: Double = 2.5) -> [ActualWarmUpSet] {
        var warmUpSets: [ActualWarmUpSet] = []

        for (element) in self.sortedSets {
            let reps = element.reps

            var load = element.fixedLoad
            var percent = element.percentageOfWorkingLoad

            switch element.loadType {
            case .fixedLoad:
                percent = load/workingLoad
            case .percentage:
                load = ((workingLoad * percent)/weightIncrement).rounded() * weightIncrement
            }
            warmUpSets.append(ActualWarmUpSet(reps: reps, load: load, percent: percent))
        }

        return warmUpSets
    }

    /// Computed property to return warm-up sets in sorted order
    var sortedSets: [WarmUpSchemaSet] {
        sets.sorted { $0.order < $1.order }
    }
}
