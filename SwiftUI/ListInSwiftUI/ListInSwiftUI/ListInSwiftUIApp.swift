//
//  ListInSwiftUIApp.swift
//  ListInSwiftUI
//
//  Created by Куприянов Тимофей on 17.12.2025.
//

import SwiftUI

@main
struct ListInSwiftUIApp: App {
    @StateObject private var cartViewModel = CartViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartViewModel)
        }
    }
}
