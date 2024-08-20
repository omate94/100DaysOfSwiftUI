//
//  ContentView.swift
//  FriendFace
//
//  Created by Oláh Máté on 20/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    var body: some View {
        NavigationStack {
            List(users, id: \.self.id) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(user.isActive ? .green : .gray)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                DetailsView(user: user)
            }
            .navigationTitle("FriendFace")
        }
        .task {
            await loadData()
        }
            
    }
    
    private func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([User].self, from: data)
            users = decodedResponse
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
