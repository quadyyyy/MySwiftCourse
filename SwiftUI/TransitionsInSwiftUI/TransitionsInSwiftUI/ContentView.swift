//
//  ContentView.swift
//  TransitionsInSwiftUI
//
//  Created by Куприянов Тимофей on 04.01.2026.
//

import SwiftUI

extension AnyTransition {
    static var zoomAsymmetricInOut: AnyTransition {
        .asymmetric(insertion: .scale(scale: 0.1, anchor: .topLeading)
            .combined(with: .offset(x: 100)),
                    removal: .scale(scale: 0.2)
            .combined(with: .opacity))
    }
}



struct ContentView: View {
    @State var isAlertShown = false
    
    
    var body: some View {
        ZStack() {
            Color("background")
            HStack {
                Text("transitions")
                    .font(.title)
                    .foregroundStyle(.black)
                Spacer()
                questionMarkView
            }
            .blur(radius: isAlertShown ? 10 : 0)
            .padding()
            
            if isAlertShown {
                alertView
                    .transition(AnyTransition.zoomAsymmetricInOut)
                    .zIndex(10)
            }
        }
        .ignoresSafeArea()
    }
    
    
    var questionMarkView: some View {
        Button {
            withAnimation {
                isAlertShown.toggle()
            }
        } label: {
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color("action"))
        }
    }
    
    
    var alertView: some View {
        VStack(spacing: 20) {
            Text("Documents copied")
                .foregroundStyle(.white)
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.white)
            Button("Cancel") {
                withAnimation {
                    isAlertShown.toggle()
                }
            }
            .foregroundStyle(Color(.red))
        }
        .padding(35)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color("alert")))
        .padding(.top, 100)
        .shadow(radius: 15)
    }
}

#Preview {
    ContentView()
}
