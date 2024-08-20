//
//  DetailsView.swift
//  FriendFace
//
//  Created by Oláh Máté on 20/08/2024.
//

import SwiftUI

struct DetailsView: View {
    let user: User
    var body: some View {
        ScrollView {
            VStack() {
                ZStack {
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.gray)
                    
                    Text(getInitials())
                        .font(.system(size: 60))
                        .foregroundStyle(.white)
                }
                
                HStack {
                    Text("\(user.name), \(user.age)")
                        .font(.title)
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(user.isActive ? .green : .gray)
                }
                
                Text(user.email)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Text(user.company)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                
                Text(user.about)
                    .padding(.vertical, 16)
                
                VStack(alignment: .leading) {
                    Text("Friends")
                        .font(.title2)
                    
                    ForEach(user.friends, id: \.self.id) { friend in
                        HStack {
                            Text(friend.name)
                                .padding(.horizontal, 8)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 5))
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func getInitials() -> String {
        let components = user.name.components(separatedBy: " ")
        let first = String(components[0].first!)
        let second = String(components[1].first!)
        return first + second
    }
}

#Preview {
    DetailsView(user: User(id: "asd",
                           isActive: false,
                           name: "Test User",
                           age: 32,
                           company: "Test Company",
                           email: "test@test.test",
                           address: "Test str 0",
                           about: "Test test test test",
                           registered: Date.now,
                           friends: [Friend(id: "1", name: "Test USer"),
                                     Friend(id: "1", name: "Test USer"),
                                     Friend(id: "1", name: "Test USer"),
                                     Friend(id: "1", name: "Test USer"),
                                     Friend(id: "1", name: "Test USer")]))
}

