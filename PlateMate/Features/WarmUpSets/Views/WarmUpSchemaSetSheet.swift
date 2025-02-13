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
    var onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Number of reps") {
                    RepsView(reps: $reps)
                }
                Section("Percentage of working load") {
                    PercentageSelector(value: $percentageOfWorkingLoad)
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
                    Button(action: {
                        onSave()
                        dismiss()
                    }, label: {
                        Text("Add")
                    })
            )
        }
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
    
    struct Preview: View {
        @State var reps = 10
        @State var percentage = 0.25
        
        var body: some View {
            WarmUpSchemaSetSheet(
                reps: $reps,
                percentageOfWorkingLoad: $percentage,
                onSave: {})
        }
    }
    
    return Preview()
}
