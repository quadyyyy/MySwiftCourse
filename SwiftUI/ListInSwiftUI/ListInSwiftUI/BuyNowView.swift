//
//  BuyNowView.swift
//  ListInSwiftUI
//
//  Created by Куприянов Тимофей on 20.12.2025.
//

import SwiftUI

struct BuyNowView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Buy screen")
                    .font(.title)
                    .bold()

                Text("This is a full screen modal. Use the Back button to dismiss.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Buy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    BuyNowView()
}
