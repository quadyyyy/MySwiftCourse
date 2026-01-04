//
//  ContentView.swift
//  AnimationsInSwiftUI
//
//  Created by Куприянов Тимофей on 31.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State var isStarted = false
    @State var CircleProgress: CGFloat = 1.0
    
    
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Button {} label: {
                    Image(systemName: "bag.badge.plus")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 15, height: 15)
                        .padding()
                        .clipShape(Circle())
                        .rotationEffect(Angle.degrees(isStarted ? 0 : -90))
                }
                .background(Circle().fill(.orange)
                    .shadow(color: .black, radius: 5))
                .offset(x: 0, y: isStarted ? -70 : 0)
                .opacity(isStarted ? 1 : 0)
                
                
                Button {
                    withAnimation(.spring()) {
                        isStarted.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 15, height: 15)
                        .padding()
                        .clipShape(Circle())
                        .rotationEffect(Angle.degrees(isStarted ? 0 : -90))
                }
                .background(Circle().fill(.orange)
                    .shadow(color: .black, radius: 5))
                .offset(x: 0, y: isStarted ? -70 : 0)

                
                Button {} label: {
                    Image(systemName: "calendar.badge.plus")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 15, height: 15)
                        .padding()
                        .clipShape(Circle())
                        .rotationEffect(Angle.degrees(isStarted ? 0 : -90))
                }
                .background(Circle().fill(.orange)
                    .shadow(color: .black, radius: 5))
                .offset(x: isStarted ? -70 : 0, y: 0)
                .opacity(isStarted ? 1 : 0)
 
                
            }
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}



//VStack {
//    Spacer()
//    Circle()
//        .trim(from: 0, to: CircleProgress)
//        .stroke(.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
//        .frame(height: 300)
//        .padding(40)
//        .rotationEffect(.degrees(-90))
//    Rectangle()
//        .foregroundStyle(.orange)
//        .frame(width: 100, height: 100)
//        //.offset(x: 0, y: isStarted ? 300 : 0)
//        //.position(isStarted ? CGPoint(x: 205, y: 300) : CGPoint(x: 205, y: 50))
//        //.opacity(isStarted ? 0 : 1)
//        //.rotationEffect(Angle.degrees(isStarted ? 190 : 360))
//        .scaleEffect(isStarted ? 0.5 : 1, anchor: .bottomLeading)
//    Spacer()
//    Button("Animate") {
//        withAnimation(.linear(duration: 1)) {
//            isStarted.toggle()
//            CircleProgress = isStarted ? 1.0 : 0.1
//        }
//    }
//}
