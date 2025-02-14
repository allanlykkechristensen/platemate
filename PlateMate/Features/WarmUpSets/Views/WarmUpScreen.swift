//
//  WarmUpScreen.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 13/02/2025.
//

import SwiftUI
import SwiftData

struct WarmUpScreen: View {

    // MARK: - Environmental dependencies
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - State
    @State var workingSetWeight: Int
    @State var selectedWarmUpSchema: WarmUpSchema?

    @Query(sort: \WarmUpSchema.name) private var warmUpSchemas: [WarmUpSchema]

    @State var warmUpSets: [ActualWarmUpSet] = []

    @AppStorage("lastSelectedWarmUpSchemaID") private var lastSelectedWarmUpSchemaID: String?

    public init(workingSetWeight: Int = 0) {
        self.workingSetWeight = workingSetWeight
    }

    public var body: some View {
        NavigationView {
            List {
                Section("Working Weight") {
                    HStack {
                        Spacer()
                        WeightPicker(numberOfDigits: 4, value: $workingSetWeight)
                            .onChange(of: workingSetWeight, calculateWarmupSets)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }

                Section("Warm-up Sets") {
                    Picker("Schema", selection: $selectedWarmUpSchema) {
                        ForEach(warmUpSchemas) { schema in
                            Text("\(schema.name)").tag(schema as WarmUpSchema?)
                        }
                    }.onChange(of: selectedWarmUpSchema) {
                        saveSelection()
                        calculateWarmupSets()
                    }
                    ForEach(warmUpSets, content: WarmUpRowView.init)
                }
            }
            .navigationTitle("Warm-up Pyramid")
            .task {
                restoreSelection()
            }
        }
    }

    // MARK: - Behaviours
    func calculateWarmupSets() {
        if let useWarmUpSchema = selectedWarmUpSchema {
            warmUpSets = useWarmUpSchema.calculate(workingLoad: Double(workingSetWeight))
        }
    }

    /// Restores the last selected schema from user preferences
    func restoreSelection() {
        if let savedID = lastSelectedWarmUpSchemaID,
           let restoredSchema = warmUpSchemas.first(where: { $0.id.uuidString == savedID }) {
            selectedWarmUpSchema = restoredSchema
        } else {
            selectedWarmUpSchema = warmUpSchemas.first
        }
        calculateWarmupSets()
    }

    /// Saves the selected schema's ID to user preferences
    func saveSelection() {
        if let selectedSchema = selectedWarmUpSchema {
            lastSelectedWarmUpSchemaID = selectedSchema.id.uuidString
        }
    }
}

#Preview {
    WarmUpScreen(workingSetWeight: 250)
        .modelContainer(for: WarmUpSchema.self, inMemory: true)
}
