//
//  PercentageSelector.swift
//  Plate Mate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 11/02/2025.
//

import SwiftUI

public struct PercentageSelector: View {

    @Binding public var value: Double
    public var step = 0.025
    public var minimum = 0.0
    public var maximum = 1.25
    public var smallestValue = 0.0
    var formatter = PercentageSelector.percentageFormatter

    private func increment() {
        value += step
    }

    private func decrement() {
        value = max(value - step, smallestValue)
    }

    public init(value: Binding<Double>) {
        self._value = value
    }

    public var body: some View {
        HStack {
            Slider(value: $value, in: minimum...maximum, step: step)

            Stepper(
                onIncrement: increment,
                onDecrement: decrement) {

                    TextField("",
                              value: $value,
                              formatter: formatter)
                    .keyboardType(.numbersAndPunctuation)
                }
        }
    }

    static let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}

#Preview {
    struct Preview: View {
        @State var percentage = 0.775

        var body: some View {
            PercentageSelector(value: $percentage)
        }
    }

    return Preview()
}
