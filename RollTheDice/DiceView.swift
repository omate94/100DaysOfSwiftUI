//
//  DiceView.swift
//  RollTheDice
//
//  Created by Oláh Máté on 22/09/2024.
//

import SwiftUI

struct DiceView: View {
    let value: Int
    
    var body: some View {
        Text("\(value)")
            .font(.largeTitle)
            .frame(width: 65, height: 65)
            .background(.white)
            .clipShape(.rect(cornerRadius: 5))
            .overlay(
                  RoundedRectangle(cornerRadius: 5)
                      .stroke(.black, lineWidth: 1)
              )
    }
}

#Preview {
    DiceView(value: 2)
}
