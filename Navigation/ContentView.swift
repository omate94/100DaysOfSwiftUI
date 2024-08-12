//
//  ContentView.swift
//  Navigation
//
//  Created by Oláh Máté on 11/08/2024.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

//struct DetailView: View {
//    var number: Int
//    @Binding var path: [Int]
//
//    var body: some View {
//        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
//            .navigationTitle("Number: \(number)")
//            .toolbar {
//                Button("Home") {
//                    path.removeAll()
////                                    path = NavigationPath()
//                }
//            }
//    }
//}

struct DetailView: View {
    var number: Int

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
//    @State private var path = [Int]()
//    @State private var path = NavigationPath()
    @State private var pathStore = PathStore()
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack() {
//        NavigationStack(path: $path) {
//        NavigationStack(path: $pathStore.path) {
//            VStack {
//                List(0..<100) { i in
//                    NavigationLink("Select \(i)", value: i)
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//            
//            VStack {
//                Button("Show 32") {
//                    path = [32]
//                }
//
//                Button("Show 64") {
//                    path.append(64)
//                }
//                
//                Button("Show 32 and64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
            
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number: \(i)", value: i)
//                }
//
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String: \(i)", value: String(i))
//                }
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the string \(selection)")
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            .toolbar {
//                Button("Push 556") {
//                    path.append(556)
//                }
//
//                Button("Push Hello") {
//                    path.append("Hello")
//                }
//            }
//            DetailView(number: 0, path: $path)
//                            .navigationDestination(for: Int.self) { i in
//                                DetailView(number: i, path: $path)
//                            }
//            DetailView(number: 0)
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i)
//                }
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbar(.hidden, for: .navigationBar)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Tap Me") {
//                        // button action here
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Tap Me") {
//                        // button action here
//                    }
//                }
//
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Or Tap Me") {
//                        // button action here
//                    }
//                }
//            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap Me") {
                        // button action here
                    }

                    Button("Tap Me 2") {
                        // button action here
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
