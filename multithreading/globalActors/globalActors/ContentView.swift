//
//  ContentView.swift
//  globalActors
//
//  Created by Куприянов Тимофей on 20.02.2026.
//

import SwiftUI
import Combine

@globalActor struct FirstGlobalActor {
    static var shared = MyDataManager()
}

actor MyDataManager {
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Three", "Four", "Five"]
    }
}



class GlobalActorViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    let manager = FirstGlobalActor.shared
    
    @FirstGlobalActor func getData() async {
        let data = await manager.getDataFromDatabase()
        self.dataArray = data
    }
}

struct ContentView: View {
    @StateObject private var viewModel = GlobalActorViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    ContentView()
}
