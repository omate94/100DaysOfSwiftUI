//
//  Card.swift
//  Flashzilla
//
//  Created by Oláh Máté on 08/09/2024.
//

import Foundation
import SwiftData

@Model
class Card {
    @Attribute(.unique) let uuid: UUID
    let prompt: String
    let answer: String
    let created: Date
    
    init(prompt: String, answer: String) {
        self.uuid = UUID()
        self.prompt = prompt
        self.answer = answer
        self.created = Date.now
    }

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
