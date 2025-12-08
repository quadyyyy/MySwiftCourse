//
//  LoginView.swift
//  NavigationDestination
//
//  Created by Куприянов Тимофей on 07.12.2025.
//

import SwiftUI

struct LoginView: View {
    @Binding var path: [Route]
    @State private var login = ""
    @State private var password = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Text("Login Page")
                .font(.largeTitle)

            TextField("Login", text: $login)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                path = [.mainPage]
            }
            .buttonStyle(.borderedProminent)

            Button("Back") {
                dismiss()
            }
            .padding(.top, 8)
        }
        .padding()
    }
}

