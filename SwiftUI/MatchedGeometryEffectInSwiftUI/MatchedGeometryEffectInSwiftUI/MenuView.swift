//
//  ContentView.swift
//  MatchedGeometryEffectInSwiftUI
//
//  Created by Куприянов Тимофей on 04.02.2026.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedTab: String
    
    
    @State private var selected = "Food"
    private let menu = ["Drinks", "Food", "Bakery"]
    
    var body: some View {
        VStack(spacing: 150) {
            ForEach(menu, id: \.self) { item in
                ZStack(alignment: .bottom) {
                    if selected == item {
                        menuItemView
                    }
                    
                    Text(item)
                        .foregroundStyle(selected == item ? .black : .black.opacity(0.3))
                        .frame(height: 70)
                        .scaleEffect(selected == item ? 1.3 : 0.8)
                        .offset(y: -10)
                }
                .frame(width: 75)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = item
                        selectedTab = item
                    }
                }
            }
            .rotationEffect(Angle(degrees: 270))
        }
        .background(
            RoundedRectangle(cornerRadius: 75)
                .fill(Color("Background"))
                .frame(width: 50, height: UIScreen.main.bounds.height + 100)
        )
        .offset(x: -10)
    }
    
    @Namespace private var menuSpace
    @Namespace private var menuSpace2
    
    
    private var menuItemView: some View {
        VStack {
            Circle()
                .fill(Color("Background"))
                .matchedGeometryEffect(id: menuSpace2, in: menuSpace2)
                .frame(width: 80, height: 80)
                .offset(y: 10)
            
            Circle()
                .fill(Color.orange)
                .matchedGeometryEffect(id: "menuSpace", in: menuSpace2)
                .frame(width: 6, height: 6)
                .offset(y: -15)
        }
    }
}

#Preview {
    MenuView(selectedTab: .constant("Food"))
}
