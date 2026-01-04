//
//  ContentView.swift
//  GesturesInSwiftUI
//
//  Created by Куприянов Тимофей on 20.12.2025.
//

import SwiftUI

struct LongView: View {
    @State var tapped = false
    
    var long: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .onEnded { _ in
                withAnimation {
                    self.tapped.toggle()
                }
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(tapped ? .blue : .red)
                .frame(width: 140, height: 100)
            Text("long press me!")
        }
        .gesture(long)
    }
}


struct DragView: View {
    @State var isDragging = false
    @State var currentOffsetX: CGFloat = 0
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    currentOffsetX = value.translation.width
                    self.isDragging.toggle()
                }
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    self.isDragging.toggle()
                    self.currentOffsetX = 0
                }
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isDragging ? .blue : .red)
                .frame(width: 140, height: 100)
            Text("drag me!")
        }
        .offset(x: currentOffsetX)
        .gesture(drag)
    }
}


struct RotationView: View {
    @State private var angle = Angle(degrees: 0.0)

    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    self.angle = Angle(degrees: 0.0)
                }
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
                .frame(width: 140, height: 100)
            Text("Rotate me")
        }
        .rotationEffect(angle)
        .gesture(rotation)
    }
}


struct ContentView: View {
    var body: some View {
        RotationView()
    }
}

#Preview {
    ContentView()
}
