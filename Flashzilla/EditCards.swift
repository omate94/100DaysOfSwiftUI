//
//  EditCards.swift
//  Flashzilla
//
//  Created by Oláh Máté on 08/09/2024.
//

import SwiftUI
import SwiftData

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    private let dataProvider: CardDataProvider
    
    init(dataProvider: CardDataProvider) {
        self.dataProvider = dataProvider
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }

                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }
    
    private func done() {
        dismiss()
    }
    
    private func loadData() {
        cards = dataProvider.cards
    }

    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        dataProvider.saveData(card: card)
        loadData()

        newPrompt = ""
        newAnswer = ""
    }

    private func removeCards(at offsets: IndexSet) {
        let cardsToDelete = offsets.map { cards[$0] }
        dataProvider.remove(cards: cardsToDelete)
        loadData()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        return EditCards(dataProvider: CardDataProvider(modelContext: container.mainContext))
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
