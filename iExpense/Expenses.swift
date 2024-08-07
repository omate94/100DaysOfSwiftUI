//
//  Expenses.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import Foundation

@Observable
class Expenses {
    private let key = "Items"
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
