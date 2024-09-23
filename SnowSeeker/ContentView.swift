//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Oláh Máté on 23/09/2024.
//

import SwiftUI

struct ContentView: View {
    private enum Order {
        case `default`
        case country
        case alphabetical
        
    }
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var order: Order = .default
    
    private let resorts: [Resort] = Bundle.main.decode("resorts.json")
    private var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    private var sortedResorts: [Resort] {
        switch order {
        case .default:
            filteredResorts
        case .country:
            filteredResorts.sorted {
                $0.country < $1.country
            }
        case .alphabetical:
            filteredResorts.sorted {
                $0.name < $1.name
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Order", systemImage: "arrow.up.arrow.down") {
                    Picker("Order", selection: $order) {
                        Text("Default")
                            .tag(Order.default)
                        Text("Country")
                            .tag(Order.country)
                        Text("Alphabetical")
                            .tag(Order.alphabetical)
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
