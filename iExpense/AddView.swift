//
//  AddView.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Add new expense"
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]
    
    var body: some View {
//        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ManagedExpenseItem(name: name, type: type, amount: amount)
//                        expenses.items.append(item)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                       dismiss()
                    }
                }
            }
//        }
    }
}

#Preview {
    return AddView()
}
