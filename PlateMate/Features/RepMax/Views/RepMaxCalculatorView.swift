//
//  RepMaxCalculatorView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import SwiftUI

struct RepMaxCalculatorView: View {
    @State private var weight: String = "100"
    @State private var reps: String = "10"
    @State private var selectedFormula: OneRepMaxFormula = EpleyFormula() // Default formula
    @State private var repMaxes: [RepMax] = []

    let formulas: [OneRepMaxFormula] = [EpleyFormula(), BrzyckiFormula(), LanderFormula(), LombardiFormula()]

    var body: some View {
        NavigationView {
            Form {
                Section("Enter Your Set") {
                    HStack {
                        Text("Weight (kg)")
                        Spacer()
                        TextField("Weight", text: $weight)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                    
                    HStack {
                        Text("Reps")
                        Spacer()
                        TextField("Reps", text: $reps)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                    }
                }
                
                Section("Formula") {
                    Picker("Formula", selection: Binding(
                        get: { selectedFormula.name },
                        set: { newValue in
                            if let newFormula = formulas.first(where: { $0.name == newValue }) {
                                selectedFormula = newFormula
                            }
                        }
                    )) {
                        ForEach(formulas.map { $0.name }, id: \.self) { formula in
                            Text(formula)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    RepMaxEstimatesView(repMaxs: repMaxes, highlightRep: Int(reps) ?? 0)
                }
            }
            .navigationTitle("RepMax Calculator")
            .onChange(of: weight) {_, _ in calculateRepMaxes() }
            .onChange(of: reps) {_, _ in calculateRepMaxes() }
            .onChange(of: selectedFormula.name) {_, _ in  calculateRepMaxes() }
            .task {
                calculateRepMaxes()
            }
        }
    }

    func calculateRepMaxes() {
        guard let weightValue = Double(weight), let repsValue = Int(reps), repsValue > 0 else { return }
        let calculator = RepMaxCalculator(formula: selectedFormula)
        repMaxes = calculator.calculateRepMaxes(from: weightValue, reps: repsValue)
    }
}

#Preview {
    RepMaxCalculatorView()
}
