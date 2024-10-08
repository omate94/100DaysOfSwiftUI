//
//  GridLayout.swift
//  Moonshot
//
//  Created by Oláh Máté on 11/08/2024.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
//                    NavigationLink(value: mission) {
//                        MissionView(mission: mission, astronauts: astronauts)
//                    } label: {
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                 Text(mission.displayName)
                                     .font(.headline)
                                     .foregroundStyle(.white)
                                 Text(mission.formattedLaunchDate)
                                     .font(.caption)
                                     .foregroundStyle(.white.opacity(0.5))
                             }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .background(.darkBackground)
        }
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return GridLayout(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
