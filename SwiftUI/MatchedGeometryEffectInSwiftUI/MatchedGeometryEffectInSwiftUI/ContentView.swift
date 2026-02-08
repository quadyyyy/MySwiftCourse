//
//  ContentView.swift
//  MatchedGeometryEffectInSwiftUI
//
//  Created by Куприянов Тимофей on 05.02.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selected = "Food"
    var body: some View {
        
        HStack {
            MenuView(selectedTab: $selected)
            Spacer()
            if selected == "Food" {
                plateView
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .offset(y: -500), removal: .offset(y: 600)))
            }
            Spacer()
        }
    }
    
    var plateView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("Background"))
            .frame(width: 200, height: 300)
            .overlay(
                Text("Лосось на гриле")
                    .bold()
                    .foregroundStyle(.orange)
            )
            .overlay(
                Circle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 200, height: 200)
            )
            .overlay(
                Image("plate")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(x: -30, y: -20)
            )
    }
}

#Preview {
    ContentView()
}
