//
//  ContentView.swift
//  RefreshableModifier
//
//  Created by Куприянов Тимофей on 21.02.2026.
//

import SwiftUI
import Combine

final class DataService {
    func getData() async throws -> [String] {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        return ["Apple", "Banana", "Orange", "Pineapple", "Strawberry"].shuffled()
    }
}


@MainActor
final class RefreshableModifierViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    let manager = DataService()
    
    func loadData() async {
        do {
            items = try await manager.getData()
        } catch {
            print(error)
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = RefreshableModifierViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle(Text("Refreshable Modifier"))
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}
