//
//  FaceNoteApp.swift
//  FaceNote
//
//  Created by Oláh Máté on 04/09/2024.
//

import SwiftUI
import SwiftData

@main
struct FaceNoteApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Person.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
}
