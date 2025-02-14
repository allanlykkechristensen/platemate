//
//  WarmUpSchemaSetRow.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 14/02/2025.
//
import SwiftUI

struct WarmUpSchemaSetRow: View {

    @State var warmUpSet: WarmUpSchemaSet

    var body: some View {
        HStack {
            switch warmUpSet.loadType {
            case .fixedLoad:
                Text("\(warmUpSet.reps) x \(warmUpSet.fixedLoad.formatted())")
            case .percentage:
                Text("\(warmUpSet.reps) x \(warmUpSet.percentageOfWorkingLoad.formatted(.percent))")

            }
        }
    }
}
