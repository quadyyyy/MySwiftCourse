//
//  ContentView.swift
//  NavigationDestination
//
//  Created by Куприянов Тимофей on 07.12.2025.
//

import SwiftUI

enum Route: Hashable {
    case login
    case mainPage
}

struct ContentView: View {
    @State private var path: [Route] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Welcome to the app!")
                    .font(Font.largeTitle)
                Button("Go to login") {
                    path.append(Route.login)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .login:
                    LoginView(path: $path)
                case .mainPage:
                    MainView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
