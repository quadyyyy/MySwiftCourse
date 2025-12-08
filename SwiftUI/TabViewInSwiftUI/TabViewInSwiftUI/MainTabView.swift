//
//  ContentView.swift
//  TabViewInSwiftUI
//
//  Created by Куприянов Тимофей on 07.12.2025.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("First", systemImage: "1.square.fill", value: 0) {
                HomeView(selectedTab: $selectedTab)
            }

            Tab("Second", systemImage: "2.square.fill", value: 1) {
                ZStack {
                    Color.white
                        .ignoresSafeArea(edges: .top)
                    Text("Another Tab")
                }
            }
            .badge("!")

            Tab("Third", systemImage: "3.square.fill", value: 2) {
                ZStack {
                    Color.gray
                    Text("The Last Tab")
                }
            }
        }
        .font(.headline)
        .tint(.red)
    }
}


struct HomeView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea(edges: .top)
            VStack {
                Text("The first tab")
                    .font(.largeTitle)
                    .padding()
                    .foregroundStyle(Color(.white))
                
                Button {
                    selectedTab = 2
                } label: {
                    Text("Go to cart")
                        .font(.headline)
                        .padding(1)
                        .padding(.horizontal)
                        .background(.white)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
