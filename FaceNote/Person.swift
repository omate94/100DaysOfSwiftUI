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
    @Attribute(.unique) let id: UUID
    let name: String
    let locationLong: Double
    let locationLat: Double
    @Attribute(.externalStorage) let photo: Data
    
    init(name: String, photo: Data, locationLong: Double, locationLat: Double) {
        self.id = UUID()
        self.name = name
        self.photo = photo
        self.locationLat = locationLat
        self.locationLong = locationLong
    }
    
}
