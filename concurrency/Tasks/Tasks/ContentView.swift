//
//  ContentView.swift
//  Tasks
//
//  Created by Куприянов Тимофей on 15.02.2026.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        for x in array {
            // work
            
            try Task.checkCancellation()
        }
        
        
        
        
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image = UIImage(data: data)
                print("Image returned successfully")
            }
            self.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            self.image2 = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskHomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("click me", destination: {
                    ContentView()
                })
            }
        }
    }
}


struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
        
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            self.fetchImageTask = Task {
//                print(Thread.current)
//                print(Task.currentPriority.rawValue)
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage2()
//            }
            
//            Task(priority: .high) {
//                await Task.yield()
//                print("high: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            Task(priority: .userInitiated) {
//                print("userInitiated: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            Task(priority: .medium) {
//                print("medium: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            Task(priority: .utility) {
//                print("utility: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            Task(priority: .low) {
//                print("Low: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            Task(priority: .background) {
//                print("background: \(Thread.current): \(Task.currentPriority.rawValue)")
//            }
//            high: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 25
//            userInitiated: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 25
//            medium: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 21
//            utility: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 17
//            Low: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 17
//            background: <_NSMainThread: 0x600001700040>{number = 1, name = main}: 9
            
            
//            Task(priority: .low) {
//                print("low: \(Thread.current): \(Task.currentPriority.rawValue)")
//                
//                Task.detached {
//                    print("low1: \(Thread.current): \(Task.currentPriority.rawValue)")
//                }
//            }
            
            
    }
}

#Preview {
    TaskHomeView()
}
