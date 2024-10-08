//
//  ContentView.swift
//  Flashzilla
//
//  Created by Oláh Máté on 08/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var cards = Array<Card>(repeating: .example, count: 10)
    private let dataProvider: CardDataProvider
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(modelContext: ModelContext) {
        dataProvider = CardDataProvider(modelContext: modelContext)
    }
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { correct in
                            withAnimation {
                                removeCard(at: getIndex(of: card), correct: correct)
                            }
                        }
                        .stacked(at: getIndex(of: card), in: cards.count)
                        .allowsHitTesting(getIndex(of: card) == cards.count - 1)
                        .accessibilityHidden(getIndex(of: card) < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, correct: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, correct: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: {
            EditCards(dataProvider: dataProvider)
        })
        .onAppear(perform: resetCards)
    }
    
    private func removeCard(at index: Int, correct: Bool) {
        guard index >= 0 else { return }
        
        let item = cards[index]
        cards.remove(at: index)
    
        if correct == false {
            cards.insert(Card(prompt: item.prompt, answer: item.answer), at: 0)
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    private func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()  
    }
    
    private func getIndex(of card: Card) -> Int {
        return cards.firstIndex { $0.id == card.id }!
    }
    
    private func loadData() {
        cards = dataProvider.cards
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        return ContentView(modelContext: container.mainContext)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
