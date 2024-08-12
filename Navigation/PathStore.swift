//
//  PathStore.swift
//  Navigation
//
//  Created by Oláh Máté on 11/08/2024.
//

import Foundation
import SwiftUI

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }
    
//    var path: NavigationPath {
//        didSet {
//            save()
//        }
//    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
            
//            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//                path = NavigationPath(decoded)
//                return
//            }
        }

        // Still here? Start with an empty path.
        path = []
//        path = NavigationPath()
    }

    func save() {
//        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(path)
//            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}
