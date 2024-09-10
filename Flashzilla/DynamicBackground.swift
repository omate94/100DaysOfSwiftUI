//
//  DynamicBackground.swift
//  Flashzilla
//
//  Created by Oláh Máté on 09/09/2024.
//

import SwiftUI

struct DynamicBackground: ViewModifier {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    var offset: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : (offset == .zero ? .white : .red))
            )
    }
}
