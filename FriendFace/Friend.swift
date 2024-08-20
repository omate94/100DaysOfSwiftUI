//
//  Friend.swift
//  FriendFace
//
//  Created by Oláh Máté on 20/08/2024.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Hashable {
    let id: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
