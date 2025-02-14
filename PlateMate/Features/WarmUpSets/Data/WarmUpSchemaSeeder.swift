//
//  WarmUpSchemaSeeder.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 14/02/2025.
//

import SwiftData

struct WarmUpSchemaSeeder {
    static func insertDefaultWarmUpSchemasIfNeeded(context: ModelContext) {

        let fetchDescriptor = FetchDescriptor<WarmUpSchema>()
        if let existingSchemas = try? context.fetch(fetchDescriptor), !existingSchemas.isEmpty {
            return  // Data already exists
        }

        let defaultSchemas: [WarmUpSchema] = [
            WarmUpSchema(name: "1RM Warm-Up", note: "Warm-up sets for a one-rep-max", sets: [
                WarmUpSchemaSet(order: 1, reps: 15, fixedLoad: 20.0),
                WarmUpSchemaSet(order: 2, reps: 8, percentageOfWorkingLoad: 0.5),
                WarmUpSchemaSet(order: 3, reps: 4, percentageOfWorkingLoad: 0.6),
                WarmUpSchemaSet(order: 4, reps: 3, percentageOfWorkingLoad: 0.7),
                WarmUpSchemaSet(order: 5, reps: 2, percentageOfWorkingLoad: 0.8),
                WarmUpSchemaSet(order: 6, reps: 1, percentageOfWorkingLoad: 0.85),
                WarmUpSchemaSet(order: 7, reps: 1, percentageOfWorkingLoad: 0.90)
            ]),
            WarmUpSchema(name: "Simple Warm-Up", note: "Simple warm-up for strength training", sets: [
                WarmUpSchemaSet(order: 1, reps: 10, percentageOfWorkingLoad: 0.25),
                WarmUpSchemaSet(order: 2, reps: 5, percentageOfWorkingLoad: 0.5),
                WarmUpSchemaSet(order: 3, reps: 5, percentageOfWorkingLoad: 0.8)
            ]),
            WarmUpSchema(name: "Classic Pyramid Warm-Up", note: "Gradually increase weight to prepare for heavy lifts", sets: [
                WarmUpSchemaSet(order: 1, reps: 10, percentageOfWorkingLoad: 0.5),
                WarmUpSchemaSet(order: 2, reps: 8, percentageOfWorkingLoad: 0.6),
                WarmUpSchemaSet(order: 3, reps: 6, percentageOfWorkingLoad: 0.7),
                WarmUpSchemaSet(order: 4, reps: 3, percentageOfWorkingLoad: 0.8),
                WarmUpSchemaSet(order: 5, reps: 1, percentageOfWorkingLoad: 0.9)
            ]),
            WarmUpSchema(name: "Speed & Power Warm-Up", note: "Focuses on bar speed and explosiveness", sets: [
                WarmUpSchemaSet(order: 1, reps: 10, fixedLoad: 20.0),
                WarmUpSchemaSet(order: 2, reps: 6, percentageOfWorkingLoad: 0.5),
                WarmUpSchemaSet(order: 3, reps: 4, percentageOfWorkingLoad: 0.65),
                WarmUpSchemaSet(order: 4, reps: 2, percentageOfWorkingLoad: 0.75),
                WarmUpSchemaSet(order: 5, reps: 1, percentageOfWorkingLoad: 0.85)
            ]),
            WarmUpSchema(name: "Strength-Specific Warm-Up", note: "For preparing muscles for heavy loads", sets: [
                WarmUpSchemaSet(order: 1, reps: 8, percentageOfWorkingLoad: 0.4),
                WarmUpSchemaSet(order: 2, reps: 6, percentageOfWorkingLoad: 0.55),
                WarmUpSchemaSet(order: 3, reps: 4, percentageOfWorkingLoad: 0.7),
                WarmUpSchemaSet(order: 4, reps: 2, percentageOfWorkingLoad: 0.8),
                WarmUpSchemaSet(order: 5, reps: 1, percentageOfWorkingLoad: 0.9)
            ]),
            WarmUpSchema(name: "Volume Warm-Up", note: "For hypertrophy-focused training", sets: [
                WarmUpSchemaSet(order: 1, reps: 12, percentageOfWorkingLoad: 0.3),
                WarmUpSchemaSet(order: 2, reps: 10, percentageOfWorkingLoad: 0.5),
                WarmUpSchemaSet(order: 3, reps: 8, percentageOfWorkingLoad: 0.65),
                WarmUpSchemaSet(order: 4, reps: 6, percentageOfWorkingLoad: 0.75)
            ]),
            WarmUpSchema(name: "Reverse Pyramid Warm-Up", note: "Starts heavier, then lowers weight gradually", sets: [
                WarmUpSchemaSet(order: 1, reps: 3, percentageOfWorkingLoad: 0.8),
                WarmUpSchemaSet(order: 2, reps: 5, percentageOfWorkingLoad: 0.7),
                WarmUpSchemaSet(order: 3, reps: 8, percentageOfWorkingLoad: 0.6),
                WarmUpSchemaSet(order: 4, reps: 10, percentageOfWorkingLoad: 0.5)
            ])
        ]

        for schema in defaultSchemas {
            context.insert(schema)
        }

        try? context.save()
    }
}
