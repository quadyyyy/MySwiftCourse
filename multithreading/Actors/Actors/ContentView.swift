//
//  ContentView.swift
//  Actors
//
//  Created by Куприянов Тимофей on 19.02.2026.
//

import SwiftUI
internal import Combine

// 1. what is the problme that actors are solving?
// 2. how was this problem solved prior to actors?

actor MyDataManager {
    static let instance = MyDataManager()
    private init() { }
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    nonisolated func getSavedData() -> String {
        
        let data = getRandomData()
        
        return "New Data"
    }
}



struct HomeView: View {
    
    let manager = MyDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil)
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.largeTitle)
        }
        .onAppear {
            
            
            Task {
                let newString = await manager.getSavedData()
            }
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
            
        }
    }
}

struct BrowseView: View {
    
    let manager = MyDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil)
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.8).ignoresSafeArea()
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }

        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
