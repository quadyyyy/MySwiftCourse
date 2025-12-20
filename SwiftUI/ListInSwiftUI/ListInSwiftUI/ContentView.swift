//
//  ContentView.swift
//  ListInSwiftUI
//
//  Created by Куприянов Тимофей on 17.12.2025.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let price: String
}

struct ContentView: View {
    @StateObject private var cartVM = CartViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Shop", systemImage: "mecca", value: 0) {
                ProductListView()
            }
            
            Tab("Cart", systemImage: "cart", value: 1) {
                CartView()
            }
        }.tabViewStyle(.automatic)
    }
    
}



#Preview {
    ContentView()
        .environmentObject(CartViewModel())
}
