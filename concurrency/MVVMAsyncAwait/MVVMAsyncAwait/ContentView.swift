//
//  ContentView.swift
//  MVVMAsyncAwait
//
//  Created by Куприянов Тимофей on 21.02.2026.
//

import SwiftUI
import Combine

final class ClassDataManager {
    func getData() async throws -> String {
        "Some data"
    }
}

actor ActorDataManager {
    func getData() async throws -> String {
        "Some data"
    }
}

@MainActor
final class MVVMViewModel: ObservableObject {
    let managerClass = ClassDataManager()
    let managerActor = ActorDataManager()
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published private(set) var myData: String = "Starting text"
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel()})
        tasks = []
    }

    func onCallToActionButtonPressed() {
        let task = Task {
            do {
                myData = try await managerClass.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
}


struct ContentView: View {
    @StateObject private var viewModel = MVVMViewModel()
    var body: some View {
        VStack {
            Button(viewModel.myData) {
                viewModel.onCallToActionButtonPressed()
            }
        }
        .onDisappear {
            
        }
    }
}

#Preview {
    ContentView()
}
