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
    private let viewModel: ViewModel
    
    init(person: Person) {
        self.viewModel =  ViewModel(person: person)
    }
    
    var body: some View {
        VStack {
            Group {
                if let image = UIImage(data: viewModel.person.photo) {
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
                Map(initialPosition: viewModel.getStartPosition()) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: viewModel.person.locationLat, longitude: viewModel.person.locationLong)) {
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
        .navigationTitle(viewModel.person.name)
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
