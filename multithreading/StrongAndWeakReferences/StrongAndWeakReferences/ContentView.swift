//
//  ContentView.swift
//  StrongAndWeakReferences
//
//  Created by Куприянов Тимофей on 20.02.2026.
//

import SwiftUI
import Combine

final class DataService {
    
    func getData() async -> String {
        "updated data"
    }
}

final class ReferencesViewModel: ObservableObject {
    @Published var data: String = "Some title"
    let dataService = DataService()
    
    private var someTask: Task<Void, Never>? = nil
    private var myTasks: [Task<Void, Never>] = []
    
    func cancelTask() {
        someTask?.cancel()
        someTask = nil
        
        myTasks.forEach({$0.cancel()})
        myTasks = []
    }
    
    // this implies a strong reference
    func updateData() {
        Task {
            data = await dataService.getData()
        }
    }
    
    // this is a strong reference
    func updateData2() {
        Task {
            self.data = await dataService.getData()
        }
    }
    
    // this is a strong reference
    func updateData3() {
        Task { [self] in
            self.data = await dataService.getData()
        }
    }
    
    // this is a weak reference
    func updateData4() {
        Task { [weak self] in
            if let data = await self?.dataService.getData() {
                self?.data = data
            }
        }
    }
    
    // we don't need to manage weak/strong
    // we can manage the task!
    func updateData5() {
        someTask = Task {
            self.data = await dataService.getData()
        }
    }
    
    // we can manage the task!
    func updateData6() {
        let task1 = Task {
            self.data = await self.dataService.getData()
        }
        myTasks.append(task1)
        
        let task2 = Task {
            self.data = await self.dataService.getData()
        }
        myTasks.append(task2)
    }
    
    // we purposely do not cancel tasks to keep strong references 
    func updateData7() {
        Task {
            self.data = await self.dataService.getData()
        }
        Task.detached {
            self.data = await self.dataService.getData()
        }
    }

}

struct ContentView: View {
    @StateObject private var viewModel = ReferencesViewModel()
    var body: some View {
        Text(viewModel.data)
            .onAppear {
                viewModel.updateData()
            }
            .onDisappear {
                viewModel.cancelTask()
            }
    }
}

#Preview {
    ContentView()
}
