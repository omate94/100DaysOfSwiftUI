//
//  DetailsView.swift
//  HabitTracker
//
//  Created by Oláh Máté on 12/08/2024.
//

import SwiftUI

struct DetailsView: View {
    @State var habitItem: HabitItem
    let habits: Habits
    
    var body: some View {
        VStack {
            Text(habitItem.details)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                .padding(.vertical, 10)
            
            Text("Complated \(habitItem.numberOfPractices) times")
                .padding(.vertical, 20)
            
            Button("Add practice") {
                addPractice()
            }
            .frame(width: 200, height: 50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(.rect(cornerRadius: 15))

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle(habitItem.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
    
    private func addPractice() {
        habitItem.addPractice()
        let idx = habits.items.firstIndex {
            $0.id == habitItem.id
        }
        
        guard let idx else {
            fatalError("Item is missing")
        }
        
        habits.items[idx] = habitItem
    }
}

#Preview {
    let habits = Habits.testData
    return DetailsView(habitItem: habits.items[0], habits: habits)
}
