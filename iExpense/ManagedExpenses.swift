//
//  ManagedExpenses.swift
//  iExpense
//
//  Created by Oláh Máté on 20/08/2024.
//

import Foundation
import SwiftData

@Model
class ManagedExpenses {
    var items: [ManagedExpenseItem]

    init(items: [ManagedExpenseItem]) {
        self.items = items
    }
}
