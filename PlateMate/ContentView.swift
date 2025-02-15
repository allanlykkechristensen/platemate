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
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: WarmUpSchema.self, inMemory: true)
}
