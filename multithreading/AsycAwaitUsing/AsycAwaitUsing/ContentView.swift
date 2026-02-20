//
//  ContentView.swift
//  AsycAwaitUsing
//
//  Created by Куприянов Тимофей on 14.02.2026.
//

import SwiftUI
internal import Combine

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title3 = "3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
        
    }
    
    
    func addAuthor1() async {
        let author1 = "Author1: \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author2: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(author2)
            
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        }
        
    }
    
    func addSomething() async  {
        try? await Task.sleep(nanoseconds: 2000000000)
        
        let something1 = "something1: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(something1)
            
            let something2 = "something2: \(Thread.current)"
            self.dataArray.append(something2)
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSomething()
                
                let finalText = "Final Text"
                viewModel.dataArray.append(finalText)
            }
            
            
//            viewModel.addTitle1()
//            viewModel.addTitle2()
        }
    }
}

#Preview {
    ContentView()
}
