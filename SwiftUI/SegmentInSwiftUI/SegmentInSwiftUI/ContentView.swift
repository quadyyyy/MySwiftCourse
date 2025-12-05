//
//  ContentView.swift
//  SegmentInSwiftUI
//
//  Created by Куприянов Тимофей on 04.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State var companies = ["Nike", "Adidas", "Puma", "Reebok"]
    @State var selectedCompany = "Nike"
    @State var offsetByX = 0
    @State var defaultShoeSize = 43
    @State var avialiableSizes = [43, 44, 45, 46]

    var body: some View {
        VStack {
            Text("Selected brand - \(selectedCompany)")
                .font(Font.system(.title2))
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .offset(x: CGFloat(offsetByX))
                    .padding()
                Image(selectedCompany)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                    .offset(x: CGFloat(offsetByX))
            }
            
            Picker("", selection: $selectedCompany) {
                ForEach(companies, id: \.self) { company in
                    Text(company).tag(company)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: selectedCompany) { _, _ in
                offsetByX = -500
                self.moveBack()
            }
            Spacer().frame(height: 150)
        }
        Picker("Shoe Size", selection: $defaultShoeSize) {
            ForEach(avialiableSizes, id: \.self) { size in
                Text("\(size)").tag(size)
            }
        }
    }
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.3)) {
                self.offsetByX = 0
            }
        }
    }
}

#Preview {
    ContentView()
}
