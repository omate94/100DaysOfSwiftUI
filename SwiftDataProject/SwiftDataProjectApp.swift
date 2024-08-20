//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Oláh Máté on 18/08/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
