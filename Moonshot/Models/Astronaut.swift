//
//  Astronaut.swift
//  Moonshot
//
//  Created by Oláh Máté on 08/08/2024.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
