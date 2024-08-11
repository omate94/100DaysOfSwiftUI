//
//  RectangleDivider.swift
//  Moonshot
//
//  Created by Oláh Máté on 11/08/2024.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleDivider()
}
