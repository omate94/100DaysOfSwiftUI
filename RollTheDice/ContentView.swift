//
//  ContentView.swift
//  RollTheDice
//
//  Created by Oláh Máté on 19/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var numberOfDice = 4
    @State private var numberOfSlides = 4
    @State private var results = [Int](repeating: 1, count: 5)
    @State private var showingHistory = false
    @State private var rollButtonEnabled = true
    
    private let possibleSides = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Number of dice:")
                    
                    Spacer()
                    
                    Picker("Number of dice", selection: $numberOfDice) {
                        ForEach(1..<6) {
                            Text("\($0) dice")
                        }
                    }
                    .onChange(of: numberOfDice) {
                        results = [Int](repeating: 1, count: numberOfDice + 1)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Number of sides:")
                    
                    Spacer()
                    
                    Picker("Number of sides", selection: $numberOfSlides) {
                        ForEach([4, 6, 8, 10, 12, 20, 100], id: \.self) {
                            Text("\($0) sides")
                        }
                    }
                    .onChange(of: numberOfSlides) {
                        results = [Int](repeating: 1, count: numberOfDice + 1)
                    }

                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal, 20)
                
                HStack {
                    ForEach(0..<results.count, id: \.self) { idx in
                        DiceView(value: results[idx])
                    }
                }
                .padding(.top, 64)
                .padding(.bottom, 32)
                
                Text("Total: \(results.reduce(0, +))")
                    .font(.largeTitle)
                
                Button() {
                    roll()
                } label: {
                    Text("Roll!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(rollButtonEnabled ? .blue : .gray)
                    .clipShape(.capsule)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .font(.title)
                    .foregroundStyle(.white)
                }
                .disabled(!rollButtonEnabled)
                
                Spacer()
            }
            .navigationTitle("RollTheDice")
            .background(.thinMaterial)
            .toolbar {
                Button("History") {
                    showingHistory = true
                }
            }
            .sheet(isPresented: $showingHistory) {
                HistoryView()
            }
            .sensoryFeedback(.increase, trigger: rollButtonEnabled == true)
        }
    }
    
    private func roll() {
        rollButtonEnabled = false
        var counter = 10
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            results = (0...numberOfDice).map { _ in Int.random(in: 1...numberOfSlides) }

            if counter == 0 {
                timer.invalidate()
                modelContext.insert(RollResult(dice: results))
                counter = 10
                rollButtonEnabled = true
            }
            
            counter -= 1
        }
    }

}

#Preview {
    ContentView()
}
