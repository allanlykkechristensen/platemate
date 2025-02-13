//
//  WarmUpRowView.swift
//  Tracker
//
//  Created by Allan Lykke Christensen on 26/03/2023.
//

import SwiftUI

struct WarmUpRowView: View {

    @State var warmUpSet: ActualWarmUpSet

    var body: some View {
        HStack {
            Text("\(warmUpSet.reps) x \(warmUpSet.load, specifier: "%.2f")")
            Spacer()
            Text("\(warmUpSet.percent*100, specifier: "%.0f")%")
        }
    }
}

struct WarmUpRowView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpRowView(warmUpSet: ActualWarmUpSet(reps: 10, load: 57.5, percent: 0.5))
    }
}
