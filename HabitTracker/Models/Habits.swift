//
//  Habits.swift
//  HabitTracker
//
//  Created by Oláh Máté on 12/08/2024.
//

import Foundation

@Observable
class Habits {
    private let key = "Items"
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    init(items: [HabitItem]) {
        self.items = items
    }
    
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

extension Habits {
    static let testData = Habits(items: [HabitItem(name: "Test 0",
                                                   details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sodales purus eget metus luctus, vel finibus augue placerat. Quisque ut leo sed neque interdum ultricies in id mi. In hac habitasse platea dictumst. Suspendisse mattis sem vitae est interdum maximus. Fusce euismod, eros id eleifend porttitor, est nibh lacinia diam, nec imperdiet lorem orci ut sem. Etiam blandit, est eu efficitur pellentesque, nulla urna tristique velit, in tristique diam dolor vehicula ante. In magna metus, maximus quis orci vel, dapibus auctor ligula. Morbi dictum sit amet mi bibendum tincidunt. Etiam sem ex, dignissim eget nisi eu, finibus ornare nibh.",
                                                   numberOfPractices: 4),
                                         HabitItem(name: "Test 1",
                                                   details: "Test",
                                                   numberOfPractices: 2),
                                         HabitItem(name: "Test 2",
                                                   details: "Test",
                                                   numberOfPractices: 0)])
}
