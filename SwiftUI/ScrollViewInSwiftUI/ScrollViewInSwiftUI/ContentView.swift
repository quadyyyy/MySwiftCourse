//
//  ContentView.swift
//  ScrollViewInSwiftUI
//
//  Created by Куприянов Тимофей on 14.12.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            headerView
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(1..<3, id: \.self) { _ in
                                cardView
                            }
                        }
                    }
                    
                    ForEach(1..<20, id: \.self) { _ in
                        paymentView
                    }
                    
                    Spacer()
                        .frame(height: 150)
                }
                
            }
            .background(Color.white)
            .padding(.top, 20)
        }
        .background(
            Color.black
                .opacity(0.8)
                .ignoresSafeArea(.all, edges: .all)
        )
    }
    
    var headerView: some View {
        HStack {
            Text("My accounts")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Spacer()
            Image(systemName: "bell.and.waveform.fill")
                .font(.title)
                .foregroundStyle(Color.white)
                .frame(width: 20, height: 20, alignment: .topTrailing)
        }
        .padding(.horizontal, 10)
    }
    
    var cardView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [Color.black.opacity(0.9), Color.black], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: UIScreen.main.bounds.width - 30, height: 200)
            
            cardItemView
        }
        .padding()
    }
    
    
    
    
    var paymentView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("MIR")
                .font(.headline)
                .fontWeight(Font.Weight.bold)
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text("Apple")
                    .font(.headline)
                    .fontWeight(Font.Weight.bold)
                Text("30.03.2022")
                    .foregroundStyle(Color.gray)
                    .font(.caption)
                    .fontWeight(.light)
            }
            Spacer()
            Text("+$100")
                .font(.headline)
                .fontWeight(Font.Weight.bold)
                .foregroundStyle(.green)
        }
        .padding(.horizontal)
    }
    
    
    var cardItemView: some View {
        VStack(alignment: .leading) {
            Text("TBank")
                .foregroundStyle(Color.white)
                .font(.title2)
                .fontWeight(Font.Weight.bold)
            
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Circle()
                        .fill(Color.white)
                        .frame(width: 6, height: 6, alignment: .bottom)
                }
                Text("4561")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .fontWeight(Font.Weight.bold)
                Spacer()
                Text("MIR")
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .fontWeight(Font.Weight.bold)
            }
            .frame(height: 130, alignment: .bottom)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
