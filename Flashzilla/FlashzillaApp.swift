//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Oláh Máté on 08/09/2024.
//

import SwiftUI
import SwiftData

@main
struct FlashzillaApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Card.self)
        } catch {
            fatalError("Failed to create ModelContainer for Card.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
}
