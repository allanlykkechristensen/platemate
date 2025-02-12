//
//  WarmUpSchemaListView.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import SwiftUI
import SwiftData

struct WarmUpSchemaListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WarmUpSchema.name) private var warmUpSchemas: [WarmUpSchema]

    public var body: some View {
        List {
            ForEach(warmUpSchemas) { warmUpSchema in
                NavigationLink(destination: Text("\(warmUpSchema.name)")) {
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
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addNewWarmUpSchema) {
                    Label("Add Warm-up Schema", systemImage: "plus")
                }
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

    private func addNewWarmUpSchema() {
        withAnimation {
            let newSchema = WarmUpSchema(name: "New Schema", note: "Example note")
            modelContext.insert(newSchema)
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
