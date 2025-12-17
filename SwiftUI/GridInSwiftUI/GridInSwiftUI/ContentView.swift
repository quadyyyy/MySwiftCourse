//
//  ContentView.swift
//  GridInSwiftUI
//
//  Created by Куприянов Тимофей on 14.12.2025.
//

import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            profileSection
            storiesSection
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: nil ,
                      pinnedViews: [.sectionHeaders]) {
                photoSection
            }
        }.clipped()
    }
    
    
    var photoSection: some View {
        Section {
            ForEach(0..<50) { index in
                Image("image1")
                    .resizable()
                    .scaledToFit()
            }
        } header: {
            HStack(spacing: 150) {
                Button {
                    
                } label: {
                    Image(systemName: "photo.stack.fill")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "iphone.rear.camera")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "video.fill")
                }
            }
            .padding()
            .background(.white)
        }
    }
    
    var storiesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<10, id: \.self) { _ in
                    VStack {
                        Image("story")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(
                                    LinearGradient(
                                        colors: [.pink, .orange, .yellow, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                            )
                        Text("Кисленько ")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var profileSection: some View {
        Section {
            HStack(spacing: 80) {
                VStack {
                    Image("grid")
                        .resizable()
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                        .shadow(color: .red, radius: 10)
                    Text("Twin")
                        .bold()
                }
                VStack {
                    Text("150")
                        .bold()
                    Text("Posts")
                        .bold()
                }
                VStack {
                    Text("150")
                        .bold()
                    Text("Likes")
                        .bold()
                }
            }
        } header: {
            HStack {
                Spacer()
                Text("AlbumCovers")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding()
            .background(.white)
        }
    }
}

#Preview {
    ContentView()
}
