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
    @State private var animationAmount = 1.0
    @State private var selectedFlag = -1
    @State private var animateOpacity = false
    @State private var animateSize = false
    
    private let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
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
                            selectedFlag = number
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                                animateOpacity = true
                                animateSize = true
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                        .rotation3DEffect(.degrees(number == selectedFlag ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(animateOpacity ? (number == selectedFlag ? 1 : 0.25) : 1)
                        .scaleEffect((animateSize && number != selectedFlag) ? 0.5 : 1)
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
        selectedFlag = -1
        animateOpacity = false
        animateSize = false
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
