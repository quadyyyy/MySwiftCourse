import SwiftUI

struct ProductItemView: View {
    let product: Product
    @EnvironmentObject var cartVM: CartViewModel
    @State private var showBuyNow = false

    var body: some View {
        VStack(spacing: 16) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 260)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)

            Text(product.title)
                .font(.title2)
                .bold()

            Text(product.description)
                .foregroundStyle(.gray)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)

            Spacer()

            HStack {
                Button {
                    showBuyNow = true
                } label: {
                    Text("Buy Now \n \(product.price)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button {
                    cartVM.add(product)
                } label: {
                    Text("Add to cart \n \(product.price)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .fullScreenCover(isPresented: $showBuyNow) {
                BuyNowView()
            }
            .padding(.bottom)
        }
        .padding()
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductItemView(product: .init(imageName: "1", title: "Комарик", description: "zzzzzzzzzzzzzzzzz", price: "4400 ₩"))
        .environmentObject(CartViewModel())
}
