//
//  ContentView.swift
//  HabitTracker
//
//  Created by Oláh Máté on 12/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits.testData
    @State private var path = NavigationPath()
    @State private var showingAddItem = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(habits.items) { habit in
                    NavigationLink(value: habit) {
                        HStack {
                            Text(habit.name)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    showingAddItem = true
                }
            }
            .navigationDestination(for: HabitItem.self) { habitItem in
                DetailsView(habitItem: habitItem, habits: habits)
            }
            .sheet(isPresented: $showingAddItem) {
                AddView(habits: habits)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
