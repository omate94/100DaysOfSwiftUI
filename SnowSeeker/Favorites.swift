//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Oláh Máté on 23/09/2024.
//

import Foundation

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"

    init() {
        if let storedResorts = UserDefaults.standard.stringArray(forKey: key) {
            resorts = Set(storedResorts)
        } else {
            resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: key)
    }
}
