//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
