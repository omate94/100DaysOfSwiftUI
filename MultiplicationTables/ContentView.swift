//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Oláh Máté on 06/08/2024.
//

import SwiftUI

struct Question {
    let leftNum: Int
    let rightNum: Int
    let result: Int
}

struct ContentView: View {
    @State private var isMultipleGameMode = false
    @State private var selectedTable = 1
    @State private var numberOfQuestions = 5
    @State private var questions: [Question] = []
    @State private var currentQuestion = 1
    @State private var currentAnswer = 0
    @State private var score = 0
    @State private var alertTitle = ""
    @State private var alertButtonTitle = ""
    @State private var alertMessage = ""
    @State private var showingAnswer = false
    @State private var showingResult = false
    @State private var gameInProgress = false
    
    private let numberOfQuestionsDataSource = [5, 10, 20]
   
    
    var body: some View {
            ZStack {
                Color(red: 1, green: 1, blue: 157.0 / 255.0)
                    .ignoresSafeArea()
                VStack() {
                    if !gameInProgress {
                        Text("Pick game mode")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.blue)
                        
                        HStack(spacing: 20) {
                            Text("Single")
                                .font(.title)
                                .foregroundStyle(.red)
                            Toggle("", isOn: $isMultipleGameMode)
                                .labelsHidden()
                            Text("Multiple")
                                .font(.title)
                                .foregroundStyle(.green)
                        }
    
                        
                        HStack(spacing: 0) {
                            let title = isMultipleGameMode ? "Up to..." : "Table: "
                            Text(title)
                                .font(.title)
                                .foregroundStyle(.white)
                            
                            Picker(title, selection: $selectedTable) {
                                ForEach(1..<13, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .scaleEffect(1.5)
                            .tint(.white)
                            
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(.cyan)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.vertical, 30)
                        
                        HStack() {
                            Text("Number of questions:")
                                .font(.title)
                                .foregroundStyle(.mint)
                            
                            Picker("Number of questions", selection: $numberOfQuestions) {
                                ForEach(numberOfQuestionsDataSource, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .scaleEffect(1.5)
                            .tint(.mint)
                        }
                        
                        Button("START") {
                            startGame()
                        }
                        .frame(width: 200, height: 70)
                        .background(.blue)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.vertical, 80)
                    } else {
                        Spacer()
                        
                        VStack(alignment: .center) {
                            HStack {
                                if questions.count == numberOfQuestions {
                                    Text("\(questions[currentQuestion-1].leftNum)")
                                    Text("x")
                                    Text("\(questions[currentQuestion-1].rightNum)")
                                }
                            }
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            
                            TextField("", value: $currentAnswer, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .labelsHidden()
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .frame(width: 80)
                        }
                        
                        Button("Submit") {
                            submitAnswer()
                        }
                        .frame(width: 200, height: 70)
                        .background(.blue)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.vertical, 20)
                        
                        Text("Your current score: \(score)")
                            .font(.title)
                            .foregroundStyle(.green)
                        
                        Text("Question: \(numberOfQuestions) / \(currentQuestion)")
                            .font(.title)
                            .foregroundStyle(.red)
                        
                        Button("Back to menu") {
                            backToMenu()
                        }
                        .frame(width: 200, height: 50)
                        .background(.purple)
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.vertical, 50)
                    }
                }
                .padding(.vertical, 50)
                
                .alert(alertTitle, isPresented: $showingAnswer) {
                    Button(alertButtonTitle, action: {
                        if currentQuestion == numberOfQuestions  {
                            showingResult = true
                        } else {
                            nextQuestion()
                        }
                    })
                } message: {
                    Text(alertMessage)
                }
                
                .alert("Congratulation!", isPresented: $showingResult) {
                    Button("Finish", action: {
                        backToMenu()
                    })
                } message: {
                    Text("You scored: \(score) points")
                }
            }
        }
    
    private func startGame() {
        generateQuestions()
        gameInProgress = true
        
    }
    
    private func generateQuestions() {
        for _ in 0..<numberOfQuestions {
            let leftNum = Int.random(in: 1...10)
            let rightNum = isMultipleGameMode ? Int.random(in: 1...selectedTable) : selectedTable
            let result = leftNum * rightNum
            let question = Question(leftNum: leftNum, rightNum: rightNum, result: result)
            questions.append(question)
        }
    }
    
    private func submitAnswer() {
        let isSuccess = currentAnswer == questions[currentQuestion - 1].result
        if isSuccess {
            score += 1
            alertTitle = "Correct"
            alertMessage = ""
        } else {
            alertTitle = "Wrong"
            alertMessage = "The correct answer is:  \(questions[currentQuestion - 1].result)"
        }
        alertButtonTitle = "Continue"
        showingAnswer = true
    }
    
    private func nextQuestion() {
        currentQuestion += 1
        currentAnswer = 0
    }
    
    private func backToMenu() {
        questions = []
        currentQuestion = 0
        currentAnswer = 0
        score = 0
        gameInProgress = false
    }
}

#Preview {
    ContentView()
}
