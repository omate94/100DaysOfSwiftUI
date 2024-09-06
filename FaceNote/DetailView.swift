//
//  AddView.swift
//  FaceNote
//
//  Created by Oláh Máté on 04/09/2024.
//

import SwiftUI
import SwiftData
import MapKit

struct DetailView: View {
    var person: Person
    
    private func getStartPosition() -> MapCameraPosition {
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: person.locationLat,
                                               longitude: person.locationLong),
                span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
            )
        )
    }
    
    var body: some View {
        VStack {
            Group {
                if let image = UIImage(data: person.photo) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200,height: 200)
                        .clipShape(.circle)
                        .overlay(
                            Circle()
                                .stroke(.gray, lineWidth: 2)
                        )
                        .shadow(radius: 5)
                } else {
                    Circle()
                        .frame(width: 200,height: 200)
                        .foregroundStyle(.white)
                        .overlay(
                            Circle()
                                .stroke(.gray, lineWidth: 2)
                        )
                }
            }
            .padding(.top, 16)
            .zIndex(2)
            
            MapReader { proxy in
                Map(initialPosition: getStartPosition()) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: person.locationLat, longitude: person.locationLong)) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                        }
                }
            }
            .padding(.top, -110)
            .zIndex(1)
        }
        .background(.regularMaterial)
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        let example = Person(name: "Test", photo: Data(), locationLong: 0, locationLat: 0)
        
        return DetailView(person: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
