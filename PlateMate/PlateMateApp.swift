//
//  PlateMateApp.swift
//  PlateMate
//
//  Created by Allan Lykke Christensen on 12/02/2025.
//

import SwiftUI
import SwiftData

@main
struct PlateMateApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WarmUpSchema.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
