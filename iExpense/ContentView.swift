//
//  ContentView.swift
//  iExpense
//
//  Created by Oláh Máté on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private let localCurrencyCode = Locale.current.currency?.identifier
    
    var body: some View {
        NavigationStack {
            List {
                let personalItems = expenses.items.filter { $0.type == "Personal"}
                let businessItems = expenses.items.filter { $0.type == "Business"}
                
                Section("Personal") {
                    ForEach(personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: localCurrencyCode ?? "USD"))
                                .foregroundStyle(item.amount < 101 ? (item.amount > 10 ? .orange: .green) : .red)
                        }
                    }
                    .onDelete(perform: removeItemsFromPersonal)
                }
                
                Section("Business") {
                    ForEach(businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: localCurrencyCode ?? "USD"))
                                .foregroundStyle(item.amount < 101 ? (item.amount > 10 ? .orange: .green) : .red)
                        }
                    }
                    .onDelete(perform: removeItemsFromBusiness)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    private func removeItemsFromPersonal(at offsets: IndexSet) {
        removeItem(from: "Personal", at: offsets)
    }
    
    private func removeItemsFromBusiness(at offsets: IndexSet) {
        removeItem(from: "Business", at: offsets)
    }
    
    private func removeItem(from type: String, at offsets: IndexSet) {
        let items = expenses.items.filter { $0.type == type}
        let itemToDelete = items[offsets.first ?? 0]
        let index = expenses.items.firstIndex(where: {$0.id == itemToDelete.id})
        guard let index else { return }
        expenses.items.remove(at: index)
    }

}

#Preview {
    ContentView()
}
