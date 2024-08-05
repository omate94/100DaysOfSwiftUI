//
//  ContentView.swift
//  Animations
//
//  Created by Oláh Máté on 05/08/2024.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

//Use iPad to test it
struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled2 = false
    @State private var dragAmount2 = CGSize.zero
    
    @State private var isShowingRed = false
    @State private var isShowingRed2 = false

    
    var body: some View {
        print(animationAmount2)
        return VStack {
            Spacer()
            
            Button("Tap Me") {
//                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
//            .scaleEffect(animationAmount)
//            .blur(radius: (animationAmount - 1) * 3)
//            .animation(.default, value: animationAmount)
//            .animation(.linear, value: animationAmount)
//            .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
//            .animation(.easeInOut(duration: 2), value: animationAmount)
//            .animation(
//                .easeInOut(duration: 2)
//                    .delay(1),
//                value: animationAmount
//            )
//            .animation(
//                .easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true),
//                value: animationAmount
//            )
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2
            }
//            .animation(
//                .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: true),
//                value: animationAmount
//            )
            
            Divider()
            
//            Stepper("Scale amount", value: $animationAmount2.animation(), in: 1...10)
            Stepper("Scale amount", value: $animationAmount2.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Button("Tap Me") {
                animationAmount2 += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount2)
            
            Divider()
            
            Button("Tap Me") {
//                withAnimation {
//                    animationAmount += 360
//                }
                
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            
            Divider()
            
            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(nil, value: enabled)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
            .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
            
            Divider()
            
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            withAnimation(.bouncy) {
                                dragAmount = .zero
                            }
                        }
                )
//                .animation(.bouncy, value: dragAmount)
            
            Divider()
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled2 ? .blue : .red)
                        .offset(dragAmount2)
                        .animation(.linear.delay(Double(num) / 20), value: dragAmount2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount2 = $0.translation }
                    .onEnded { _ in
                        dragAmount2 = .zero
                        enabled2.toggle()
                    }
            )
            
            Divider()
            
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Divider()
            
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)

                if isShowingRed2 {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed2.toggle()
                }
            }
            
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
