//
//  String+IsNotEmpty.swift
//  Bookworm
//
//  Created by Oláh Máté on 15/08/2024.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }
}
