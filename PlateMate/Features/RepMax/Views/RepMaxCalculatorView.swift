//
//  RepMaxCalculatorView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import SwiftUI

struct RepMaxCalculatorView: View {
    enum Sheet: String, Identifiable {
        case formulaSelection

        var id: String { rawValue }
    }

    @State private var weight: String = "100"
    @State private var reps: String = "10"
    @AppStorage("defaultRepMaxFormula") private var defaultFormulaName = "Epley"
    @State private var selectedFormula: OneRepMaxFormula = EpleyFormula()
    @State private var repMaxes: [RepMax] = []
    @State private var presentedSheet: Sheet?

    let formulas = FormulaFactory.formulas

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

                Section {
                    ScrollView(.vertical) {
                        RepMaxEstimatesView(repMaxs: repMaxes, highlightRep: Int(reps) ?? 0)
                        Text("Using the \(selectedFormula.name) formula based on a set of \(reps) x \(weight)")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("RepMax Calculator")
            .onAppear { loadDefaultFormula() }
            .onChange(of: weight) {_, _ in calculateRepMaxes() }
            .onChange(of: reps) {_, _ in calculateRepMaxes() }
            .onChange(of: selectedFormula.name) {_, _ in  calculateRepMaxes() }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { presentedSheet = .formulaSelection }) {
                            Label("One rep max formula", systemImage: "function")
                        }
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(item: $presentedSheet, onDismiss: { loadDefaultFormula() }, content: { sheet in
                switch sheet {
                case .formulaSelection:
                    DefaultFormulaSettingView()
                }})
            .task {
                calculateRepMaxes()
            }
        }
    }

    func calculateRepMaxes() {
        guard let weightValue = Double(weight), let repsValue = Int(reps), repsValue > 0 else { return }

        let calculator = RepMaxCalculator(reps: repsValue, load: weightValue, with: selectedFormula)

        repMaxes = []
        for repCount in 1...20 {
            repMaxes
                .append(
                    .init(
                        reps: repCount,
                        weight: calculator.calculateRepMaxLoad(
                            reps: repCount
                        ),
                        intensity: calculator.calculateIntensity(
                            reps: repCount
                        )
                    )
                )
        }
    }

    func loadDefaultFormula() {
        selectedFormula = FormulaFactory.formula(named: defaultFormulaName)
    }
}

#Preview {
    RepMaxCalculatorView()
}
