//
//  WarmUpSchemaDetailView.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 11/02/2025.
//

import SwiftUI

struct WarmUpSchemaDetailView: View {

    @State var warmUpSchema: WarmUpSchema
    @State var showAddSet = false
    @State var reps = 0
    @State var percentageOfWorkingLoad = 0.0
    @State var fixedLoad = 0.0
    @State var order = 0

    var onUpdate: (_ warmUpSchema: WarmUpSchema) -> Void

    var body: some View {
        Form {

            Section("Description") {
                TextField("Name of schema", text: $warmUpSchema.name)
                TextField("Schema description", text: $warmUpSchema.note)
            }

            Section("Sets") {
                List {
                    ForEach(warmUpSchema.sortedSets) { warmUpSet in
                        WarmUpSchemaSetRow(warmUpSet: warmUpSet)
                    }.onDelete(perform: removeWarmUpSet)
                }

                Button(action: { onShowAddSet() }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Set")
                    }
                })
            }
        }
        .sheet(isPresented: $showAddSet, content: {
            WarmUpSchemaSetSheet(
                reps: $reps,
                percentageOfWorkingLoad: $percentageOfWorkingLoad,
                fixedLoad: $fixedLoad,
                onSave: onAddSet)
        })

        .navigationTitle("Warm-up Schema")
        .onChange(of: warmUpSchema.name) {
            updateWarmUpSet()
        }
        .onChange(of: warmUpSchema.note) {
            updateWarmUpSet()
        }
    }

    func removeWarmUpSet(at indexSet: IndexSet) {
        warmUpSchema.sets.remove(atOffsets: indexSet)
        onUpdate(warmUpSchema)
    }

    func updateWarmUpSet() {
        onUpdate(warmUpSchema)
    }

    func onAddSet() {
        warmUpSchema.sets.append(WarmUpSchemaSet(
            id: .init(),
            order: order,
            reps: reps,
            fixedLoad: fixedLoad,
            percentageOfWorkingLoad: percentageOfWorkingLoad
        ))
        onUpdate(warmUpSchema)
    }

    func onShowAddSet() {
        showAddSet = true
        order = order + 1
        reps = 0
        percentageOfWorkingLoad = 0.0
        fixedLoad = 0.0
    }
}

#Preview {
    WarmUpSchemaDetailView(
        warmUpSchema: WarmUpSchema(
            id: .init(),
            name: "Name of warm-up schema",
            note: "Description of the schema",
            sets: [
                .init(id: .init(), reps: 10, fixedLoad: 20.0),
                .init(id: .init(), reps: 5, percentageOfWorkingLoad: 0.5),
                .init(id: .init(), reps: 4, percentageOfWorkingLoad: 0.65),
                .init(id: .init(), reps: 3, percentageOfWorkingLoad: 0.70),
                .init(id: .init(), reps: 2, percentageOfWorkingLoad: 0.725)
            ]),
        onUpdate: { _ in
        }
    )
}
