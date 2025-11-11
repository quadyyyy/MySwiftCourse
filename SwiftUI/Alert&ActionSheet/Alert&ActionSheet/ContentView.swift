//
//  ContentView.swift
//  Alert&ActionSheet
//
//  Created by Тимофей Куприянов on 11.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State var isError = false
    
    var body: some View {
        showAlert()
    }
    
    fileprivate func showAlert() -> some View {
        return Button(action: {
            self.isError = true
        }, label: {
            Text("Sign in")
        }).actionSheet(isPresented: $isError, content: {
            ActionSheet(title: Text("Loading"),
                        message: Text("Are you sure want to continue?"),
                        buttons: [.destructive(Text("No")), .default(Text("Yes"), action: {print("user is sure")})])
        })
//        .alert(isPresented: $isError, content: {
//            Alert(title: Text("Test"),
//                  message: Text("окак"),
//                  primaryButton: .destructive(Text("Ok"), action: { print("test")}),
//                  secondaryButton: .cancel(Text("Nah")))
//        })
    }
    

}

#Preview {
    ContentView()
}
