//
//  HabitItem.swift
//  HabitTracker
//
//  Created by Oláh Máté on 12/08/2024.
//

import Foundation
import SwiftUI

struct HabitItem: Identifiable, Codable, Hashable {
    private(set) var id = UUID()
    let name: String
    let details: String
    private(set) var numberOfPractices: Int
    
    mutating func addPractice() {
        numberOfPractices += 1
    }
}

