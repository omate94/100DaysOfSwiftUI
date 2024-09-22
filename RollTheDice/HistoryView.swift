//
//  HistoryView.swift
//  RollTheDice
//
//  Created by Oláh Máté on 22/09/2024.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \RollResult.creationDate, order: .reverse) private var results: [RollResult]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(results) { result in
                    VStack {
                        HStack {
                            Text(result.formattedDate)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                        }
                        
                        HStack {
                            ForEach(0..<result.dice.count, id: \.self) { idx in
                                DiceView(value: result.dice[idx])
                            }
                        }
                        
                        Text("Total \(result.total)")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                    .padding(16)
                    .background(.white)
                    .clipShape(.rect(cornerRadius:10))
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .background(.thinMaterial)
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
