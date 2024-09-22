//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Oláh Máté on 19/09/2024.
//

import SwiftUI
import SwiftData

@main
struct RollTheDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RollResult.self)
    }
}
