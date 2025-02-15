//
//  RepMaxEstimatesView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import SwiftUI

struct RepMaxEstimatesView: View {

    var repMaxs: [RepMax]
    var highlightRep: Int = 10

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 90))
        ]) {
            ForEach(0 ..< repMaxs.count, id: \.self) { repCount in
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 50)
                    .overlay(
                        RepMaxCellView(
                            rep: repCount+1,
                            intensity: repMaxs[repCount].intensity,
                            load: repMaxs[repCount].weight,
                            highlight: highlightRep == repCount+1)
                    )
                    .padding()
            }
        }
    }
}

#Preview  {
    RepMaxEstimatesView(repMaxs: [.init(reps: 1, weight: 100, intensity: 1.0)])
}
