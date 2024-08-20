//
//  ManagedExpenseItem.swift
//  iExpense
//
//  Created by Oláh Máté on 20/08/2024.
//

import Foundation
import SwiftData

@Model
class ManagedExpenseItem {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double

    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
