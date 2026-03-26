//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Куприянов Тимофей on 26.03.2026.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
