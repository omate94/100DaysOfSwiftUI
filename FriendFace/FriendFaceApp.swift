//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Oláh Máté on 20/08/2024.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
