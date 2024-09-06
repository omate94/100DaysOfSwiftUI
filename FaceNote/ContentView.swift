//
//  ContentView.swift
//  FaceNote
//
//  Created by Oláh Máté on 04/09/2024.
//

import SwiftUI
import SwiftData
import PhotosUI
import LocalAuthentication

struct ContentView: View {
    @State private var viewModel: ViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext, locationFetcher: LocationFetcher())
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            if viewModel.isUnlocked {
                List(viewModel.persons) { person in
                    NavigationLink(value: person) {
                        HStack {
                            if let image = UIImage(data: person.photo) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(.circle)
                            } else {
                                Circle()
                                    .foregroundStyle(.gray)
                                    .frame(width: 40, height: 40)
                                
                            }
                            
                            Text(person.name)
                        }
                    }
                }
                .photosPicker(isPresented:$viewModel.showingPhotoPicker, selection: $viewModel.selectedItem)
                .onChange(of: viewModel.selectedItem, photoSelected)
                .navigationDestination(for: Person.self) { person in
                    DetailView(person: person)
                }
                .navigationTitle("FaceNote")
                .toolbar {
                    Button("Add item", systemImage: "plus") {
                        viewModel.showingPhotoPicker = true
                    }
                    
                    Button("Clear", systemImage: "trash") {
                        viewModel.clearItems()
                    }
                }
                .alert("Enter a name", isPresented: $viewModel.showingAlert) {
                    TextField("Enter your name", text: $viewModel.name)
                    Button("OK", action: viewModel.saveItem)
                }
                message: {
                   Text("Please try again.")
                }
            } else {
                Button("Unlock faces", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
    }
    
    private func photoSelected() {
        if viewModel.selectedItem != nil {
            DispatchQueue.main.async {
                viewModel.showingAlert = true
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        return ContentView(modelContext: container.mainContext)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
