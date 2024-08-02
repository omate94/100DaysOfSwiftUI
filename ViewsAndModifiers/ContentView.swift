//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Oláh Máté on 02/08/2024.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .titleStyle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
