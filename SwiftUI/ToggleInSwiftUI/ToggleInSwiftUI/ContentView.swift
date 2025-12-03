//
//  ContentView.swift
//  ToggleInSwiftUI
//
//  Created by Тимофей Куприянов on 11.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State var isToggleOn = false
    @State var colorScheme: Color = .yellow
    @State var showAlert = false
    @State var showSheet = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Кошелек")
                        Text("Профиль")
                        Button("Другой цвет") {
                            withAnimation {
                                colorScheme = (colorScheme == .yellow) ? .blue : .yellow
                            }
                        }
                        Button("Рофл") {
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Alert"),
                                primaryButton: .default(Text("Ok")),
                                secondaryButton: .cancel(Text("Oh..."),
                                                    action: {print("он против")}))
                        })
                        Button("Рофл 2") {
                            showSheet = true
                        }
                        .actionSheet(isPresented: $showSheet, content: {
                            ActionSheet(title: Text("О как"),
                                        message: Text("О да, все именно окак"),
                                        buttons: [.default(Text("Skibid")), .destructive(Text("Net"))])
                        })
                        
                        
                        Spacer().frame(height: 600)
                    }
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme)
                    .offset(x: isToggleOn ? 100 : 0)
                
                Text("Что-то на экране")
                    .offset(x: isToggleOn ? 100 : 0)
            }
            
            Toggle(
                isOn: $isToggleOn.animation(
                    .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)
                ),
                label: {
                    Text("Показать настройки")
                }
            )
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
