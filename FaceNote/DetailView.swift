//
//  AddView.swift
//  FaceNote
//
//  Created by Oláh Máté on 04/09/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    var person: Person
    
    var body: some View {
        VStack {
            if let image = UIImage(data: person.photo) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300,height: 300)
                    .clipShape(.circle)
            } else {
                Circle()
                    .frame(width: 300,height: 300)
                    .foregroundStyle(.gray)
            }
            
            Text(person.name)
                .font(.title)
                .padding(.bottom, 100)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        let example = Person(name: "Test", photo: Data())

        return DetailView(person: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
