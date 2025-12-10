//
//  ContentView.swift
//  TextEditorInSwiftUI
//
//  Created by Куприянов Тимофей on 10.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var totalChars = 0
    @State var lastText = ""
    
    init() {
        UITextView.appearance().backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
    }
    var body: some View {
        ZStack {
            Color.purple.opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                ProgressView("Chars: \(totalChars) / 150", value: Double(totalChars), total: 150)
                    .frame(width: 150)
                    .padding()
                    .foregroundStyle(Color.white)
                
                
                TextEditor(text: $text)
                    .padding()
                    .background(Color.yellow.opacity(0.5))
                    .foregroundStyle(Color.red)
                    .font(Font.custom("Courier New", size: 18))
                    .frame(width: 300, height: 250)
                    .onChange(of: text) { oldValue, newValue in
                        totalChars = newValue.count
                        if totalChars <= 150 {
                            lastText = newValue
                        } else {
                            text = lastText
                        }
                    }
            }
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    ContentView()
}
