//
//  ContentView.swift
//  TextFieldInSwiftUI
//
//  Created by Куприянов Тимофей on 09.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    
    // FocusState is available starting from iOS 15.0+
    @FocusState var nameIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("Login", text: $text)
                .redtext()
                .focused($nameIsFocused)
            TextField("Password", text: $text) { changed in
                print(changed)
            } onCommit: {
                print("onCommit")
            }
            .redtext()

            
            Button {
                nameIsFocused = true
                //hideKeyboard()
            } label: {
                Text("Login")
            }
        }
    }
}


struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundStyle(Color.accentColor)
            .keyboardType(.emailAddress)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(.red))
            .padding(.horizontal, 12)
    }
}


extension View {
    func redtext() -> some View {
        modifier(TextFieldModifier())
    }
}


// code for iOS below 15.0
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
