//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Oláh Máté on 02/08/2024.
//

import SwiftUI

private enum Options: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
    
    func emoji() -> String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📜"
        case .scissors:
            return "✂"
        }
    }
}


struct ContentView: View {
    private let options: [Options] = [.rock, .paper, .scissors]
    private static let numberOfTurns = 10
    @State private var currentChoice: Options = .rock
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turnsLeft = ContentView.numberOfTurns
    @State private var showingAnswer = false
    @State private var answerAlertTitle = ""
    @State private var showingResult = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                
                Text("Your opponenet picks:")
                
                Text(currentChoice.emoji() + " " + currentChoice.rawValue)
                    .font(.system(size: 50))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                
                
                Text("Your have to")
                
                Text(shouldWin ? "win" : "lose")
                    .font(.system(size: 40).bold())
                    .foregroundStyle(shouldWin ? .green : .red)
                
                Text("in this turn")
                
                Spacer()
                
                Text("Make your pick")
                
                ForEach(options, id: \.self) { option in
                    Button {
                        handleSelection(option)
                    } label: {
                        Text(option.emoji() + " " + option.rawValue)
                            .font(.system(size: 40))
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(.mint)
                            
                    }
                    .foregroundStyle(.primary)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                VStack {
                    Text("Your current score is: \(score)")
                    Text("\(turnsLeft) turns left")
                }
                .padding(20)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
            }
            .font(.system(size: 25))
            
            .alert(answerAlertTitle, isPresented: $showingAnswer) {
                Button("Continue", action: {
                    if turnsLeft == 0 {
                        showingResult = true
                    } else {
                        newTurn()
                    }
                })
            }
            
            .alert("Congratulations", isPresented: $showingResult) {
                Button("Continue", action: {
                    restart()
                })
            } message: {
                Text("Your final score is \(score)!")
            }
        }
    }
    
    private func handleSelection(_ value: Options) {
        turnsLeft -= 1
        
        switch currentChoice {
        case .rock:
            if (shouldWin && value == .paper) ||  (!shouldWin && value == .scissors) {
                score += 1
                answerAlertTitle = "Correct!"
            } else {
                answerAlertTitle = "Wrong!"
            }
        case .paper:
            if (shouldWin && value == .scissors) ||  (!shouldWin && value == .rock) {
                score += 1
                answerAlertTitle = "Correct!"
            } else {
                answerAlertTitle = "Wrong!"
            }
        case .scissors:
            if (shouldWin && value == .rock) ||  (!shouldWin && value == .paper) {
                score += 1
                answerAlertTitle = "Correct!"
            } else {
                answerAlertTitle = "Wrong!"
            }
        }
        
        showingAnswer = true
    }
    
    private func newTurn() {
        currentChoice = options.randomElement() ?? .rock
        shouldWin = Bool.random()
    }
    
    private func restart() {
        turnsLeft = ContentView.numberOfTurns
        score = 0
        newTurn()
    }
}

#Preview {
    ContentView()
}
