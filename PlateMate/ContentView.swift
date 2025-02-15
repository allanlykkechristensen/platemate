//
//  ContentView.swift
//  PlateMate
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            WarmUpScreen()
                .tabItem {
                    Label("Warm-Up", systemImage: "flame.fill")
                }

            RepMaxCalculatorView()
                .tabItem {
                    Label("RepMax", systemImage: "square.grid.3x3")
                }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: WarmUpSchema.self, inMemory: true)
}
