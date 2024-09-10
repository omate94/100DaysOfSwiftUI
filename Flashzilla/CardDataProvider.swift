//
//  CardDataProvider.swift
//  Flashzilla
//
//  Created by Oláh Máté on 10/09/2024.
//

import SwiftUI
import SwiftData

class CardDataProvider {
    private let modelContext: ModelContext
    private(set) var cards = [Card]()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadData()
    }
    
    func loadData() {
        do {
            let descriptor = FetchDescriptor<Card>(sortBy: [SortDescriptor(\.created)])
            cards = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func saveData(card: Card) {
        modelContext.insert(card)
        loadData()
    }
    
    func remove(cards: [Card]) {
        cards.forEach {
            modelContext.delete($0)
        }
        
        loadData()
    }
}
