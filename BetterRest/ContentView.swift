//
//  ContentView.swift
//  BetterRest
//
//  Created by Oláh Máté on 02/08/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = ContentView.defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
//                    
//                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                }
                
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                            .labelsHidden()
                }
                
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Desired amount of sleep")
//                        .font(.headline)
//                    
//                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Daily coffee intake")
//                        .font(.headline)
//                    
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
//                }
                
                Section("Daily coffee intake") {
                    Picker("Number of cups: ", selection: $coffeeAmount) {
                        ForEach(1..<20) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section() {
                    let bedtime = calculateBedtime() ?? .now
                    Text("Your ideal bedtime is \(bedtime.formatted(date: .omitted, time: .shortened))")
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
        }
        
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    
    private func calculateBedtime() -> Date? {
        alertTitle = "Error"
        alertMessage = "Sorry, there was a problem calculating your bedtime."
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            return sleepTime
        } catch {
            // something went wrong!
            return nil
        }
        
//        showingAlert = true
    }
}

#Preview {
    ContentView()
}
