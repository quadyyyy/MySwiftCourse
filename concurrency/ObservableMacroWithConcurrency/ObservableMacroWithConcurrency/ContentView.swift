//
//  ContentView.swift
//  ObservableMacroWithConcurrency
//
//  Created by Куприянов Тимофей on 22.02.2026.
//

import SwiftUI
import Combine

actor TitleDatabase {
    func getNewTitle() -> String {
        "Some new title"
    }
}


@Observable class ObservableMacroViewModel {
    
    @ObservationIgnored let database = TitleDatabase()
    var title: String = "Starting title"
    
    func updateTitle() async {
        title = await database.getNewTitle()
    }
}


struct ContentView: View {
    @State private var viewModel = ObservableMacroViewModel()
    var body: some View {
        Text(viewModel.title)
            .task {
                await viewModel.updateTitle()
            }
    }
}

#Preview {
    ContentView()
}
