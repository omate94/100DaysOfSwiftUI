//
//  ExpenseView.swift
//  iExpense
//
//  Created by Oláh Máté on 20/08/2024.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ManagedExpenseItem]
    
    init(type: String, sortOrder: [SortDescriptor<ManagedExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ManagedExpenseItem> { item in
            if !type.isEmpty {
                return item.type == type
            } else {
                return true
            }
        },sort: sortOrder)
    }
    
    private let localCurrencyCode = Locale.current.currency?.identifier
    
    var body: some View {
        List {
            let personalItems = expenses.filter { $0.type == "Personal"}
            let businessItems = expenses.filter { $0.type == "Business"}
            
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
    }
    
    private func removeItemsFromPersonal(at offsets: IndexSet) {
        removeItem(from: "Personal", at: offsets)
    }
    
    private func removeItemsFromBusiness(at offsets: IndexSet) {
        removeItem(from: "Business", at: offsets)
    }
    
    private func removeItem(from type: String, at offsets: IndexSet) {
        let items = expenses.filter { $0.type == type}
        let itemToDelete = items[offsets.first ?? 0]
        let index = expenses.firstIndex(where: {$0.id == itemToDelete.id})
        guard let index else { return }
//        expenses.items.remove(at: index)
        
        let item = expenses[index]
        modelContext.delete(item)
    }
}

#Preview {
    ExpenseView(type: "", sortOrder: [SortDescriptor(\ManagedExpenseItem.name)])
        .modelContainer(for: ManagedExpenseItem.self)
}
