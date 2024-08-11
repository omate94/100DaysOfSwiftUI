//
//  MissionView.swift
//  Moonshot
//
//  Created by Oláh Máté on 08/08/2024.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                     .resizable()
                     .scaledToFit()
                     .containerRelativeFrame(.horizontal) { width, axis in
                         width * 0.6
                     }
                     .padding(.top)
                
                Text("Launch date: " + mission.formattedLaunchDate)
                    .padding(.top)

                VStack(alignment: .leading) {
                    RectangleDivider()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                    
                    RectangleDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink{
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                CrewMemeberView(crewMember: crewMember)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
