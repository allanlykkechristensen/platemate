//
//  NewWarmUpSchemaSheet.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import SwiftUI

struct NewWarmUpSchemaSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var warmUpSets: [WarmUpSchemaSet] = []
    @State private var showAddSet = false
    @State private var reps: Int = 0
    @State private var percentageOfWorkingLoad: Double = 0.0
    @State private var fixedLoad: Double = 0.0
    @State private var order: Int = 0
    
    var onSave: (_ name: String, _ description: String, _ warmUpSets: [WarmUpSchemaSet]) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of schema", text: $name)
                    TextField("Schema description", text: $description)
                }
                
                Section {
                    ForEach(warmUpSets) { wuSet in
                        WarmUpSchemaSetRow(warmUpSet: wuSet)
                    }.onDelete(perform: removeWarmUpSet)
                    
                    Button(action: { onShowAddSet() }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Set")
                        }
                    })
                }
            }
            .navigationTitle("New Warm-up Schema")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        onClose()
                    }, label: {
                        Text("Cancel")
                    }),
                trailing:
                    Button(action: {
                        onSave(name, description, warmUpSets)
                        onClose()
                    }, label: {
                        Text("Add")
                    })
            )
            .sheet(isPresented: $showAddSet, content: {
                WarmUpSchemaSetSheet(
                    reps: $reps,
                    percentageOfWorkingLoad: $percentageOfWorkingLoad,
                    fixedLoad: $fixedLoad,                    
                    onSave: onAddSet)
            })
        }
    }

    // MARK: - Behaviours
    func onClose() {
        dismiss()
    }

    func onShowAddSet() {
        showAddSet = true
        order = order + 1
        reps = 0
        percentageOfWorkingLoad = 0.0
        fixedLoad = 0.0
    }

    func onAddSet() {
        warmUpSets.append(
            WarmUpSchemaSet(
                id: .init(),
                order: order,
                reps: reps,
                fixedLoad: fixedLoad,
                percentageOfWorkingLoad: percentageOfWorkingLoad
            )
        )
        showAddSet = false
    }

    func removeWarmUpSet(at offsets: IndexSet) {
        warmUpSets.remove(atOffsets: offsets)
    }

}

#Preview {
    NewWarmUpSchemaSheet(onSave: { (_, _, _) in })
}
