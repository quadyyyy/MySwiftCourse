//
//  ContentView.swift
//  DoTryCatchInSwift
//
//  Created by Куприянов Тимофей on 11.02.2026.
//

import SwiftUI
internal import Combine

// do-catch
// try
// throws

class DataManager {
    
    let isActve: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActve {
            return ("New world", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActve {
            return .success("New world")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
//        if isActve {
//            return "New world"
//        } else {
            throw URLError(.badServerResponse)
//        }
    }
    
    func getTitle4() throws -> String {
        if isActve {
            return "Final text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoTryCatchViewModel: ObservableObject {
    
    @Published var text: String = "Hello, world!"
    let manager = DataManager()
    
    func fetchTitle() {
        
//        let returnedValue = manager.getTitle()
//        if let newTitle = returnedValue.title {
//            self.text = newTitle
//        } else if let error = returnedValue.error {
//            self.text = error.localizedDescription
//        }
        
//        let result = manager.getTitle2()
//        
//        switch result {
//        case .success(let newTitle):
//            self.text = newTitle
//        case .failure(let error):
//            self.text = error.localizedDescription
//        }
        
//        let newTitle = try! manager.getTitle3()
//        self.text = newTitle
        
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch let error {
            self.text = error.localizedDescription
        }
        
    }
}

struct ContentView: View {
    @StateObject private var viewModel = DoTryCatchViewModel()
    
    var body: some View {
        Text("\(viewModel.text)")
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    ContentView()
}
