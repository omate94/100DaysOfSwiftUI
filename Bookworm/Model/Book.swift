//
//  Book.swift
//  Bookworm
//
//  Created by Oláh Máté on 15/08/2024.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    private let creationDate: Date = Date.now
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }    
    
    var formattedDate: String {
        creationDate.formatted(date: .abbreviated, time: .shortened)
    }
    
}
