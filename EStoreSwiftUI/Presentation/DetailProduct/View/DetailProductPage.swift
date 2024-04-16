//
//  DetailProductPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct DetailProductPage: View {
    var product: ProductModel
    @ObservedObject var detailVM: DetailViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ProductImageSlider(
                    listImage: detailVM.singleProduct?.images ?? []
                )
                .frame(height: 300)
                ProductListView(
                    listImage: detailVM.singleProduct?.images ?? []
                )
                    .frame(height: 100)
                    .padding(.leading, 5)
                if let detail = detailVM.singleProduct {
                    ProductDescription(product: detail)
                }
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                NavigationLink {
                    CreateProductPage(vm: AddProductViewModel(service: AddProductService(), categoryService: CategoryService()),
                      product: product, updateData: {
                        detailVM.detailProduct(id: product.id)
                    })
                } label: {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(Color("MainColor"))
                    }
                }

            }))
        }
        .onAppear {
            detailVM.detailProduct(id: product.id)
        }
    }
}

struct ProductImageSlider: View {
    var listImage = [String]()
    var body: some View {
        TabView {
            ForEach(listImage, id: \.self) { data in
                if let image = URL(string: data) {
                    AsyncImage(url: image) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                        case .failure:
                            Image("Clothes")
                                .resizable()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }else{
                    Image("dummy_clothes")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFill()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

//struct
struct ProductListView: View {
    var listImage = [String]()
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(listImage, id: \.self) { data in
                    if let image = URL(string: data) {
                        AsyncImage(url: image) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            case .failure:
                                Image("Clothes")
                                    .resizable()
                                
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical, 5)
                        .frame(width: 80, height: 80)
                    }else {
                        Image("dummy_clothes")
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.vertical, 5)
                    }
                        
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: 110
        )
    }
}

struct ProductDescription: View {
    var product: ProductModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.title)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 5)
            Text("Rp \(product.price)")
                .font(.system(size: 24))
                .foregroundStyle(Color("MainColor"))
                .fontWeight(.bold)
                .padding(.leading, 5)
            Text(
                product.description
            )
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    DetailProductPage(product: ProductModel(id: 1, title: "Black T-Shirt", price: 1, description: "Elevate your casual wardrobe with our Classic Red Pullover Hoodie.Crafted with a soft cotton blend for ultimate comfort, this vibrant ...", images: ["dummy_clothes","dummy_clothes"], creationAt: "", updatedAt: "", category: Category(id: 2, name: "", image: "dummy_clothes", creationAt: "", updatedAt: "")), detailVM: DetailViewModel(productService: ProductService()))
}
