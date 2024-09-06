//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Oláh Máté on 06/09/2024.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
