//
//  SettingsView.swift
//  PlateMate - Gym Buddy
//
//  Created by Allan Lykke Christensen on 13/02/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: WarmUpSchemaListView()) {
                        Label("Warm-Up Schemas", systemImage: "flame.fill")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
