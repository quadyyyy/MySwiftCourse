//
//  ContentView.swift
//  DisclosureGroupInSwiftUI
//
//  Created by Куприянов Тимофей on 25.01.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.black
    @State private var fontStyle = Font.Weight.regular
    @State private var textOpacityValue = 1.0
    
    var body: some View {
        ScrollView {
            Text("Текст который мы можем настроить")
                .foregroundStyle(selectedColor)
                .font(.title)
                .fontWeight(fontStyle)
                .padding(.top)
                .opacity(textOpacityValue)
            colorSettingsView
            fontSettingsView
            opacitySettingsView
            readDocView
            Spacer()
            
            
        }
    }
    
    var readDocView: some View {
        DisclosureGroup {
            if let url = URL(string: "https://developer.apple.com/documentation/swiftui/link") {
                Link("Прочитать о линке", destination: url)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.blue)
                    .padding(.top)
                
            }
        } label: {
            Text("Дополнительно")
        }
        .accentColor(Color.black)
        .padding()
    }
    
    var opacitySettingsView: some View {
        DisclosureGroup {
            Stepper("Value: \(textOpacityValue.formatted(.percent))") {
                guard textOpacityValue < 1.0 else { return }
                textOpacityValue += 0.1
            } onDecrement: {
                guard textOpacityValue > 0.1 else { return }
                textOpacityValue -= 0.1
            }
            .padding(.top)

        } label: {
            Text("Настройка прозрачности")
        }
        .accentColor(Color.black)
        .padding()
    }
    
    var fontSettingsView: some View {
        DisclosureGroup {
            ControlGroup {
                Button {
                    fontStyle = Font.Weight.regular
                } label: {
                    Text("Regular")
                }
            
                Button {
                    fontStyle = Font.Weight.bold
                } label: {
                    Text("Bold")
                }
            }
        } label: {
            Text("Настройка стиля шрифта")
        }
        .accentColor(.black)
        .padding()
    }
    
    var colorSettingsView: some View {
        DisclosureGroup {
            HStack {
                Label {
                    Text("Выберите текст")
                } icon : {
                    Image(systemName: "paintpalette.fill")
                }
                ColorPicker("", selection: $selectedColor)
            }
            .padding()
        } label: {
            Text("Настройка цвета")
        }
        .accentColor(.black)
        .padding()
    }
}

#Preview {
    ContentView()
}
