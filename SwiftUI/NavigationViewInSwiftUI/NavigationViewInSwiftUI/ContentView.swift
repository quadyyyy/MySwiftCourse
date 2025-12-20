//
//  ContentView.swift
//  NavigationViewInSwiftUI
//
//  Created by Куприянов Тимофей on 05.12.2025.
//

import SwiftUI
import Combine

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userBuy: UserBuy
    var text: String

    var body: some View {
        VStack(spacing: 10) {
            Text("Order \(userBuy.cups) cups of \(text)")
            .navigationBarItems(
                leading:
                    Button("Back to menu") {
                            dismiss()
            },
                trailing:
                    HStack {
                        Button("-") {
                            guard self.userBuy.cups > 0 else { return }
                            self.userBuy.cups -= 1
                    }
                
                Button("+") {
                    self.userBuy.cups += 1
                }
            })

        }
        .navigationBarBackButtonHidden(true)
        
        .onAppear {
            self.userBuy.cups = 0
        }
    }
}

class UserBuy: ObservableObject {
    @Published var cups = 0
}


struct ContentView: View {
    @ObservedObject var userBuy = UserBuy()
    let coffee = "Coffee"
    let tea = "Tea"

    @State private var showCoffee = false
    @State private var showTea = false

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Text("You've ordered \(userBuy.cups) cups!")
                Text("What would you like to order?")

                NavigationLink(destination: DetailView(text: coffee),
                label: {
                    Text(coffee)
                })

                NavigationLink(destination: DetailView(text: tea),
                label: {
                    Text(tea)
                })
            }
            .navigationTitle(Text("Menu"))
        }
        .environmentObject(userBuy)
    }
}

#Preview {
    ContentView()
}
