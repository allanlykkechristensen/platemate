//
//  WeightPicker.swift
//  Warm Up Sets
//
//  Created by Allan Lykke Christensen on 10/02/2025.
//

import SwiftUI

public struct WeightPicker: View {

    let numberOfDigits: Int
    @Binding var value: Int
    @State private var digitSelections: [Int]

    init(numberOfDigits: Int, value: Binding<Int>) {
        self.numberOfDigits = numberOfDigits
        self._value = value
        self._digitSelections = State(initialValue: Self.splitNumber(value.wrappedValue, numberOfDigits: numberOfDigits))
    }

    public var body: some View {

        HStack {
            ForEach(0..<numberOfDigits, id: \.self) { index in
                Picker("", selection: $digitSelections[index]) {
                    ForEach(0...9, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }.pickerStyle(WheelPickerStyle())
                    .frame(width: 70, height: 90)
                    .clipped()
            }
        }
        .onChange(of: digitSelections) { _, _ in
            value = Self.combineDigits(digitSelections)
        }
    }

    // Helper function to split a number into an array of digits
    static func splitNumber(_ number: Int, numberOfDigits: Int) -> [Int] {
        let numberString = String(format: "%0\(numberOfDigits)d", number)
        return numberString.map { Int(String($0)) ?? 0 }
    }

    // Helper function to combine digit selections into an integer
    static func combineDigits(_ digits: [Int]) -> Int {
        return digits.reduce(0) { $0 * 10 + $1 }
    }
}

#Preview {
    @Previewable @State var value = 345
    WeightPicker(numberOfDigits: 4, value: $value)
    Text("The value is \(value)")
}
