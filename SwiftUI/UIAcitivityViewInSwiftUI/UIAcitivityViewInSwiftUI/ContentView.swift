//
//  ContentView.swift
//  UIAcitivityViewInSwiftUI
//
//  Created by Куприянов Тимофей on 05.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isSharePresented: Bool = false
    let customActivity = ActivityViewCustomActivity(title: "Favorite", imageName: "star-icon", performAction: {print("saved to favorites")})
    
    var body: some View {
        Button("Share") {
            self.isSharePresented = true
        }.sheet(isPresented: $isSharePresented) {
            ActivityView(activityItems: ["message test"],
                         applicationActivities: ([self.customActivity]))
        }
    }
}

#Preview {
    ContentView()
}
