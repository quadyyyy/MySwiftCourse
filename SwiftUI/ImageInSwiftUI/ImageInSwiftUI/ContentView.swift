//
//  ContentView.swift
//  ImageInSwiftUI
//
//  Created by Куприянов Тимофей on 11.12.2025.
//

import SwiftUI

struct ContentView: View {
    let image = UIImage(named: "image1") ?? UIImage()
    
    var body: some View {
        VStack {
            backgoundImageView
            logoImageView
            Text("Добрый красивый котик")
                .foregroundStyle(Color.white)
                .fontWeight(.bold)
            asyncImageView
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            VStack {
                LinearGradient(colors: [Color.purple, Color.purple.opacity(0.2)], startPoint: .top, endPoint: .bottom)
            }
                .ignoresSafeArea(.all, edges: .all)
        )
    }
    
    var asyncImageView: some View {
        AsyncImage(url: URL(string: "https://picsum.photos/401")) { phase in
            switch phase {
            case .empty: ProgressView()
                    .tint(.accentColor)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            case .failure(let error):
                VStack {
                    Image(systemName: "exclamationmark.trianglepath")
                        .font(.system(size: 60))
                    Text("Ошибка: \(error.localizedDescription)")
                }
            @unknown default:
                fatalError()
            }
        }
    }
    
    var backgoundImageView: some View {
        Image("image4")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 690, height: 250)
            .ignoresSafeArea(.all, edges: .top)
    }
    
    var logoImageView: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .clipShape(Capsule())
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 4)
            )
            .shadow(radius: 10)
            .offset(y: -200)
            .padding(.bottom, -200)
    }
}

#Preview {
    ContentView()
}
