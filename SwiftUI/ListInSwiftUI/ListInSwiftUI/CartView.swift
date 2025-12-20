//
//  CartView.swift
//  ListInSwiftUI
//
//  Created by Куприянов Тимофей on 19.12.2025.
//

import SwiftUI
import Combine

final class CartViewModel: ObservableObject {
    @Published var items: [Product] = []

    func add(_ product: Product) {
        items.append(product)
    }

    func remove(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    var totalPrice: Int {
        items.reduce(0) { $0 + (Int($1.price) ?? 0) }
    }
}

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Your cart")
                    .bold()
                    .font(Font.largeTitle.bold())
            }
            List(cartVM.items, id: \.id) { prod in
                makeCartView(product: prod)
            }
        }
    }
    
    func makeCartView(product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading) {
                Text(product.title)
                Text(product.description)
                    .foregroundStyle(.gray)
                    .font(.caption2)
                    .fontWeight(.light)
                    .padding(.bottom)
            }
            Spacer()
            Text(product.price)
                .foregroundStyle(.green)
                .bold()
        }
        .swipeActions(edge: .leading) {
            Button {
                cartVM.remove(product)
            } label: {
                Image(systemName: "trash")
            }
                .tint(.red)
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
