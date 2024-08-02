//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Oláh Máté on 01/08/2024.
//

import SwiftUI

private enum Units {
    case milliliters, liters, cups, pints, gallons
    
    func stringValue() -> String {
        switch self {
        case .milliliters:
            "milliliters"
        case .liters:
            "liters"
        case .cups:
            "cups"
        case .pints:
            "pints"
        case .gallons:
            "gallons"
        }
    }
}

struct ContentView: View {
    @FocusState private var fromValueIsFocused: Bool
    @State private var fromValue: Double = 1.0
    @State private var fromUnit: Units = .milliliters
    @State private var toUnit: Units = .liters
    private let units: [Units] = [.milliliters, .liters, .cups, .pints, .gallons]
    
    private var toValue: Double {
        let valueInMilliliters = {
            switch fromUnit {
            case .milliliters:
                return fromValue
            case .liters:
                return Measurement(value: fromValue, unit: UnitVolume.liters)
                    .converted(to: .milliliters).value
            case .cups:
                return Measurement(value: fromValue, unit: UnitVolume.cups)
                    .converted(to: .milliliters).value
            case .pints:
                return Measurement(value: fromValue, unit: UnitVolume.pints)
                    .converted(to: .milliliters).value
            case .gallons:
                return Measurement(value: fromValue, unit: UnitVolume.gallons)
                    .converted(to: .milliliters).value
            }
        }()
        
        switch toUnit {
        case .milliliters:
            return valueInMilliliters
        case .liters:
            return Measurement(value: valueInMilliliters, unit: UnitVolume.milliliters)
                .converted(to: .liters).value
        case .cups:
            return Measurement(value: valueInMilliliters, unit: UnitVolume.milliliters)
                .converted(to: .cups).value
        case .pints:
            return Measurement(value: valueInMilliliters, unit: UnitVolume.milliliters)
                .converted(to: .pints).value
        case .gallons:
            return Measurement(value: valueInMilliliters, unit: UnitVolume.milliliters)
                .converted(to: .gallons).value
        }
    }
    
    var body: some View {
        NavigationStack {
            Form() {
                Section() {
                    Picker("From", selection: $fromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.stringValue())
                        }
                    }
                    
                    TextField("From", value: $fromValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($fromValueIsFocused)
                    
                }
                
                Section() {
                    Picker("To", selection: $toUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.stringValue())
                        }
                    }
                    Text(toValue.formatted())
                }
            }
            .navigationTitle("VolumeConverter")
            .toolbar {
                if fromValueIsFocused {
                    Button("Done") {
                        fromValueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
