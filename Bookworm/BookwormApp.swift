//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Oláh Máté on 15/08/2024.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
