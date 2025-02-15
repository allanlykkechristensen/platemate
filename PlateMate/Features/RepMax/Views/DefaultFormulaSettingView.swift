//
//  DefaultFormulaSettingView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import SwiftUI

struct DefaultFormulaSettingView: View {

    @Environment(\.dismiss) private var dismiss
    @AppStorage("defaultRepMaxFormula") private var defaultFormulaName = "Epley"

    let formulas = FormulaFactory.formulas

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Default Formula", selection: $defaultFormulaName) {
                        ForEach(formulas.map { $0.name }, id: \.self) { formula in
                            Text(formula)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("One Rep Max Formula")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Label("Close", systemImage:"xmark.circle.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    DefaultFormulaSettingView()
}
