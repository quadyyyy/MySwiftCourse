//
//  ProductListView.swift
//  ListInSwiftUI
//
//  Created by Куприянов Тимофей on 19.12.2025.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var cartVM = CartViewModel()
    var products: [Product] = [
        .init(imageName: "1", title: "Комарик", description: "zzzzzzzzzzzzzzzzz", price: "4400 ₩"),
        .init(imageName: "2", title: "Котик", description: "meeeeeow", price: "40 ₩"),
        .init(imageName: "3", title: "Открытка", description: "здравствуйте ребята", price: "300 ₩"),
    ]
    
    

    var body: some View {
        NavigationView {
            List(products, id: \.id) { product in
                NavigationLink{
                    ProductItemView(product: product)
                } label: {
                    makeProductView(product: product)
                }
                
                
                .listRowSeparator(.hidden)
            }
            .refreshable {
                print("refreshed")
            }
            .navigationTitle("Bullshit Shop")

        }
    }
    
    
    func makeProductView(product: Product) -> some View {
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
                cartVM.add(product)
            } label: {
                Image(systemName: "cart")
            }
            .tint(.green)
        }
    }
}





#Preview {
    ProductListView()
        .environmentObject(CartViewModel())
}
