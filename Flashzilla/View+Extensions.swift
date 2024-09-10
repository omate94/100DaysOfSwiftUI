//
//  View+Extensions.swift
//  Flashzilla
//
//  Created by Oláh Máté on 08/09/2024.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
    
    func dynamicBackgroundStyle(offset: CGSize) -> some View {
        modifier(DynamicBackground(offset: offset))
    }
}
