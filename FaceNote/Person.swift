//
//  Person.swift
//  FaceNote
//
//  Created by Oláh Máté on 05/09/2024.
//

import Foundation
import SwiftData

@Model
class Person: Hashable, Identifiable {
    let id: UUID
    let name: String
    @Attribute(.externalStorage) let photo: Data
    
    init(name: String, photo: Data) {
        self.id = UUID()
        self.name = name
        self.photo = photo
    }
    
}
