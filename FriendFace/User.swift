//
//  User.swift
//  FriendFace
//
//  Created by Oláh Máté on 20/08/2024.
//

import Foundation

struct User: Codable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let friends: [Friend]
}

