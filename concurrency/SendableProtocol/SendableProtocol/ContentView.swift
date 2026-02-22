//
//  ContentView.swift
//  SendableProtocol
//
//  Created by Куприянов Тимофей on 20.02.2026.
//


// Sendable can be used with final classes
// Use @unchecked Sendable when you guarantee the class is thread safe

import SwiftUI
import Combine

actor UserManager {
    func updateDataBase(userInfo: String) {
        
    }
}

struct MyUserInfo: Sendable {
    let name: String
}


// example of thread safe class
final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
}


class SendableViewModel: ObservableObject {
    let manager = UserManager()
    
    func updateUserInfo() async {
        let info = MyUserInfo(name: "Timofei")
        
        
        
        await manager.updateDataBase(userInfo: info.name)
    }
}


struct ContentView: View {
    
    @StateObject var viewModel = SendableViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            
        }
    }
}

#Preview {
    ContentView()
}
