//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Oláh Máté on 02/08/2024.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingAnswer = false
    @State private var showingResult = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score: Int = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var numberOfQuestions = 0
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
            
            .alert(alertTitle, isPresented: $showingAnswer) {
                Button("Continue", action: {
                    if numberOfQuestions == 8 {
                        showingResult = true
                    } else {
                        askQuestion()
                    }
                })
            } message: {
                Text(alertMessage)
            }
            .alert("Congratualtion", isPresented: $showingResult) {
                Button("Restart", action: restartGame)
            } message: {
                Text("You scored \(score) points")
            }
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func restartGame() {
        score = 0
        numberOfQuestions = 0
        askQuestion()
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            alertTitle = "Correct"
            alertMessage = "Your score is \(score)"
        } else {
            alertTitle = "Wrong!"
            alertMessage = "That’s the flag of \(countries[correctAnswer])"
        }
        numberOfQuestions += 1
        showingAnswer = true
    }
}

#Preview {
    ContentView()
}
