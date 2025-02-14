//
//  WarmUpSchemaSetSheet.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 11/02/2025.
//

import SwiftUI

struct WarmUpSchemaSetSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var reps: Int
    @Binding var percentageOfWorkingLoad: Double
    @Binding var fixedLoad: Double
    @State private var loadType: LoadType = .percentage
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section("Number of reps") {
                    RepsView(reps: $reps)
                }

                Section("Load Type") {
                    Picker("Specify Load As", selection: $loadType) {
                        ForEach(LoadType.allCases, id: \.self) { type in
                            Text(type.localized).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                if loadType == .percentage {
                    Section("Percentage of Working Load") {
                        PercentageSelector(value: $percentageOfWorkingLoad)
                    }
                } else {
                    Section("Fixed Load") {
                        TextField("Fixed Load", value: $fixedLoad, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationTitle("New Warm-up Set")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    }),
                trailing:
                    Button(action: addNewWarmUpSet, label: {
                        Text("Add")
                    })
            )
        }
    }

    enum LoadType: String, Codable, CaseIterable {
        case percentage
        case fixedLoad

        var localized: LocalizedStringKey {
            switch self {
            case .percentage:
                return "Percentage"
            case .fixedLoad:
                return "Fixed Load"
            }
        }
    }

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }

    private func addNewWarmUpSet() {
        switch loadType {
        case .percentage:
            fixedLoad = 0.0
        case .fixedLoad:
            percentageOfWorkingLoad = 0.0
        }
        onSave()
        dismiss()
    }
}

extension WarmUpSchemaSetSheet {
    struct RepsView: View {
        
        let incrementStep = 1
        @Binding var reps: Int
        
        func increase() {
            reps += incrementStep
        }
        
        func decrease() {
            reps = max(reps - incrementStep, 0)
        }
        
        var body: some View {
            HStack {
                TextField("Reps",
                          value: $reps,
                          formatter: NumberFormatter()
                ).keyboardType(.numberPad)
                
                Stepper(
                    label: {
                        Text("Reps")
                    },
                    onIncrement: increase,
                    onDecrement: decrease)
            }
        }
    }
}

#Preview {

    @Previewable @State var reps = 10
    @Previewable @State var percentage = 0.25
    @Previewable @State var fixedLoad = 0.0

    WarmUpSchemaSetSheet(
        reps: $reps,
        percentageOfWorkingLoad: $percentage,
        fixedLoad: $fixedLoad,
        onSave: {})

}
