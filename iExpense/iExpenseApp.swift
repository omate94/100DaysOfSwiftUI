//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ManagedExpenses.self)
    }
}
