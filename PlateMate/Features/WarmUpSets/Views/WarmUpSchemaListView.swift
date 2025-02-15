//
//  WarmUpSchemaListView.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import SwiftUI
import SwiftData

struct WarmUpSchemaListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WarmUpSchema.name) private var warmUpSchemas: [WarmUpSchema]

    @State var showAddWarmUpSchema = false

    public var body: some View {
        NavigationStack {
            List {
                ForEach(warmUpSchemas) { warmUpSchema in
                    NavigationLink(destination:
                                    WarmUpSchemaDetailView(warmUpSchema: warmUpSchema, onUpdate: onUpdateWarmUpSchema)) {
                        WarmUpSchemaListRow(name: warmUpSchema.name, description: warmUpSchema.note, warmUpSets: warmUpSchema.sets.count)
                    }
                }.onDelete(perform: deleteWarmUpSchemas)
            }
            .overlay(
                Group {
                    if warmUpSchemas.isEmpty {
                        ContentUnavailableView(
                            "No warm-up schemas",
                            systemImage: "pyramid",
                            description: Text("Tap '+' to add a new schema.")
                        )
                    }
                }
            )
            .navigationTitle("Warm-up Schemas")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Label("Dismiss", systemImage: "xmark.circle.fill")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addWarmUpSchema) {
                        Label("Add Warm-up Schema", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddWarmUpSchema) {
                NewWarmUpSchemaSheet(onSave: createWarmUpSchema)
            }
        }
    }

    private func deleteWarmUpSchemas(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(warmUpSchemas[index])
            }
        }
    }

    func addWarmUpSchema() {
        showAddWarmUpSchema = true
    }

    func createWarmUpSchema(name: String, description: String, warmUpSets: [WarmUpSchemaSet]) {
        withAnimation {
            let newSchema = WarmUpSchema(name: name, note: description)

            for set in warmUpSets {
                set.warmUpSchema = newSchema
            }
            newSchema.sets = warmUpSets

            modelContext.insert(newSchema)
        }
    }

    func onUpdateWarmUpSchema(warmUpSchema: WarmUpSchema) {
        withAnimation {
        }
    }
}

struct WarmUpSchemaListRow: View {
    var name: String
    var description: String
    var warmUpSets: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(name)")
                Text("\(description)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(warmUpSets) sets")
        }
    }
}

#Preview {
    NavigationView {
        WarmUpSchemaListView()
    }.modelContainer(for: WarmUpSchema.self, inMemory: true)
}
