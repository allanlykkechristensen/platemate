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
                        calculateWarmupSets()
                    }
                    ForEach(warmUpSets, content: WarmUpRowView.init)
                }
            }
            .navigationTitle("Warm-up Pyramid")
            .task {
                calculateWarmupSets()
            }
        }
    }

    // MARK: - Behaviours
    func calculateWarmupSets() {
        if let useWarmUpSchema = selectedWarmUpSchema {
            warmUpSets = useWarmUpSchema.calculate(workingLoad: Double(workingSetWeight))
        }
    }
}

#Preview {
    WarmUpScreen(workingSetWeight: 250)
        .modelContainer(for: WarmUpSchema.self, inMemory: true)
}
