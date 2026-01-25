//
//  ContentView.swift
//  CustomBottomSheetInSwiftUI
//
//  Created by Куприянов Тимофей on 04.01.2026.
//

import SwiftUI

struct ContentView: View {
    @GestureState private var gestureOffset = CGSize.zero
    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { value in
                let maxHeight = UIScreen.main.bounds.height - 150
                
                withAnimation {
                    if -currentMenuOffsetY > maxHeight / 2 {
                        currentMenuOffsetY = -maxHeight
                    } else {
                        currentMenuOffsetY = 0
                    }
                    
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }
    
    func onChangeMenuOffset() {
        DispatchQueue.main.async {
            self.currentMenuOffsetY = gestureOffset.height
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
            
            VStack {
                Capsule()
                    .fill(.white)
                    .frame(width: 100, height: 3)
                    .padding(.top)
                ForEach(0..<4) { _ in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Action"))
                        .frame(height: 100)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height + 100)
            .background(RoundedRectangle(cornerRadius: 40).fill(Color("Alert")))
            .ignoresSafeArea(.all, edges: .bottom)
            .offset(y: UIScreen.main.bounds.height - 30)
            .offset(y: currentMenuOffsetY)
            .gesture(dragGesture)
        }
    }
}

#Preview {
    ContentView()
}
