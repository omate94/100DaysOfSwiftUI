//
//  ContentView-ViewModel.swift
//  FaceNote
//
//  Created by Oláh Máté on 05/09/2024.
//

import Foundation
import LocalAuthentication
import SwiftUI
import PhotosUI
import SwiftData

extension ContentView {
    @Observable
    class ViewModel {
        var persons = [Person]()
        var isUnlocked = false
        var selectedItem: PhotosPickerItem?
        var showingPhotoPicker: Bool = false
        var showingAlert = false
        var name = ""
        
        private let locationFetcher: LocationFetcher
        private let modelContext: ModelContext
        
        init(modelContext: ModelContext, locationFetcher: LocationFetcher) {
            self.modelContext = modelContext
            self.locationFetcher = locationFetcher
            
            locationFetcher.start()
            fetchData()
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Person>(sortBy: [SortDescriptor(\.name)])
                persons = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

        func saveItem() {
            Task {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                      let location = locationFetcher.lastKnownLocation
                else { return }
                modelContext.insert(Person(name: name,
                                           photo: imageData,
                                           locationLong: location.longitude,
                                           locationLat: location.latitude))
                fetchData()
                name = ""
                selectedItem = nil
            }
        }
        
        func clearItems() {
            try? modelContext.delete(model: Person.self)
            fetchData()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your face."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    self.isUnlocked = success
                }
            } else {
                // no biometrics
            }
        }
    }
}
