//
//  RepMaxCellView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import SwiftUI

struct RepMaxCellView: View {

    var rep: Int
    var intensity: Double
    var load: Double
    var highlight: Bool = false

    var body: some View {
        VStack {
            Text("\(rep)RM")
                .font(.caption)
                .foregroundColor(.blue)
                .fontWeight(.bold)

            Text("\(NumberFormatter.intensityFormatter.string(from: intensity))")
                .font(.caption)
                .foregroundColor(.secondary)

            Text("\(NumberFormatter.loadFormatter.string(from: load))")
                .font(.headline)
                .fontWeight(highlight ? .bold : .regular)
        }
    }
}

#Preview("Actual RM") {
    RepMaxCellView(rep: 10, intensity: 0.8, load: 120, highlight: true)
}

#Preview("Estimated RM") {
    RepMaxCellView(rep: 10, intensity: 0.8, load: 120, highlight: false)
}
