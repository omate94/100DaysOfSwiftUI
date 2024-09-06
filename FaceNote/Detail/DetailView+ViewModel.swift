//
//  DetailView+ViewModel.swift
//  FaceNote
//
//  Created by Oláh Máté on 06/09/2024.
//

import Foundation
import SwiftUI
import MapKit

extension DetailView {
    @Observable
    class ViewModel {
        let person: Person
        
        init(person: Person) {
            self.person = person
        }
        
        func getStartPosition() -> MapCameraPosition {
            return MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: person.locationLat,
                                                   longitude: person.locationLong),
                    span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                )
            )
        }
    }
}
