//
//  ContentView.swift
//  TextInSwiftUI
//
//  Created by Куприянов Тимофей on 08.12.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Съешь же ещё этих мягких французских булок, да выпей чаю").textCase(.uppercase)
//            .font(.title)
//            .kerning(5)
//            .bold()
//            .italic()
//            .underline(true, color: .yellow)
//            .strikethrough(true, color: .blue)
//            .padding()
//            .lineLimit(nil)
//            .multilineTextAlignment(.center)
//            .background(.red)
//            .foregroundStyle(.white)
//            .lineSpacing(15)
//            .font(.system(size: 24, weight: .bold, design: .serif))
//            .frame(width: 200, height: 350, alignment: .leading)
//            .minimumScaleFactor(0.1)
        
        HStack(alignment: .top) {
            Text("Hello")
                .baselineOffset(-10)
                .border(.red)
            Text("Hello")
                .border(.green)
            Text("Hello")
                .baselineOffset(10)
                .border(.blue)
        }
    }
}

#Preview {
    ContentView()
}
