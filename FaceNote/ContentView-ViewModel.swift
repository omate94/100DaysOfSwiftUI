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
        var modelContext: ModelContext
        var persons = [Person]()
        var isUnlocked = false
        var selectedItem: PhotosPickerItem?
        var showingPhotoPicker: Bool = false
        var showingAlert = false
        var name = ""
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
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
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                modelContext.insert(Person(name: name, photo: imageData))
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
