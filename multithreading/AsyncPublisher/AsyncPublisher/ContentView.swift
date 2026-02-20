//
//  ContentView.swift
//  AsyncPublisher
//
//  Created by Куприянов Тимофей on 20.02.2026.
//

import SwiftUI
import Combine

class DataManager {
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Pineapple")
    }
}

class AsyncPublisherViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    let manager = DataManager()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribesrs()
    }
    
    private func addSubscribesrs() {
        Task {
            await MainActor.run {
                self.dataArray = ["one"]
            }
            
            
            for await value in manager.$myData.values {
                await MainActor.run {
                     self.dataArray = value
                }
            }
            
            await MainActor.run {
                self.dataArray = ["two"]
            }
        }
//        manager.$myData
//            .receive(on: DispatchQueue.main, options: nil)
//            .sink { dataArray in
//                self.dataArray = dataArray
//            }
//            .store(in: &cancellable)
    }
    
    func start() async {
        await manager.addData()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = AsyncPublisherViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    ContentView()
}
