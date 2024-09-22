//
//  RollResult.swift
//  RollTheDice
//
//  Created by Oláh Máté on 22/09/2024.
//

import Foundation

import Foundation
import SwiftData

@Model
class RollResult: Identifiable {
    @Attribute(.unique) let id: UUID
    let dice: [Int]
    let creationDate: Date
    
    init(dice: [Int]) {
        self.id = UUID()
        self.dice = dice
        self.creationDate = Date.now
    }
    
    var total: Int {
        dice.reduce(0, +)
    }
    
    var formattedDate: String {
        creationDate.formatted(date: .abbreviated, time: .shortened)
    }
    
}
