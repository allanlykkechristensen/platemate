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
}
