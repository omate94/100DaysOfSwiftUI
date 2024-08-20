//
//  ContentView.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var path = [String]()
    @State private var sortOrder = [
        SortDescriptor(\ManagedExpenseItem.name),
        SortDescriptor(\ManagedExpenseItem.amount)
    ]
    @State private var filter: String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpenseView(type: filter, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    path.append("Add Expense")
//                    showingAddExpense = true
                }
                
                Menu("Filter", systemImage: "arrow.up.arrow.down") {
                    Picker("Filter", selection: $filter) {
                        Text("Show all")
                            .tag("")
                        Text("Show Personal")
                            .tag("Personal")
                        Text("Show Business")
                            .tag("Business")
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ManagedExpenseItem.name),
                                SortDescriptor(\ManagedExpenseItem.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ManagedExpenseItem.amount),
                                SortDescriptor(\ManagedExpenseItem.name)
                            ])
                    }
                }
            }
            .navigationDestination(for: String.self) { _ in
                AddView()
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView()
        }
    }

}

#Preview {
    ContentView()
}
