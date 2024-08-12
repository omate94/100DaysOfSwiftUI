//
//  AddView.swift
//  HabitTracker
//
//  Created by Oláh Máté on 12/08/2024.
//

import SwiftUI

struct AddView: View {
    var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var details = ""
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                  TextField("Name", text: $name)
                } label: {
                  Text("Name:")
                }
                
                LabeledContent {
                  TextField("Details", text: $details)
                } label: {
                  Text("Details:")
                }
            }
            .navigationTitle("Add new habit")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = HabitItem(name: name,
                                             details: details,
                                             numberOfPractices: 0)
                        habits.items.append(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(habits: Habits.testData)
}
