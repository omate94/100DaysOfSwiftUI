//
//  ContentView.swift
//  BucketList
//
//  Created by Oláh Máté on 27/08/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    private let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        Group {
            if viewModel.isUnlocked {
                ZStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .mapStyle(viewModel.isMapStyleStandard ? .standard : .hybrid)
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                    }
                    
                    VStack() {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button(viewModel.mapStyleTitle) {
                                viewModel.isMapStyleStandard.toggle()
                                viewModel.mapStyleTitle = viewModel.isMapStyleStandard ? "Standard" : "Hybrid"
                            }
                            .frame(width: 100, height: 40)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                        }
                        .padding()
                    }
                    
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Failed to unlock your content!", isPresented: $viewModel.failedToLogin) { 
            
        } message: {
           Text("Please try again.")
        }
    }
}

#Preview {
    ContentView()
}
