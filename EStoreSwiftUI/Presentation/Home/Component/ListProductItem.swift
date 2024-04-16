//
//  ListProductItem.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct ListProductItem: View {
    var product: ProductModel
    var body: some View {
        VStack {
            HStack {
                Group {
                    if let imageString = product.images.first,
                    let imageUrl = URL(string: imageString){
                        tempAsyncImage(url: imageUrl)
                    }else {
                        Image("Clothes")
                            .resizable()
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                            .frame(width: 80, height: 80)
                            .padding()
                    }
                }
               
                VStack(alignment: .leading) {
                    
                    Text(product.title)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment:.leading)
                        .fontWeight(.bold)
         
                        .lineLimit(1)
                    
                    Text(product.description)
                        .lineLimit(3)
                    
                    Text("Rp \(product.price)")
                        .fontWeight(.bold)
                        .foregroundStyle(Color("MainColor"))
                        .padding(.vertical, 5)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.vertical)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.vertical)
            .frame(minWidth: 0, maxWidth: .infinity)
           
        }
    }
}

#Preview {
    ListProductItem(product: ProductModel(id: 0, title: "Tes", price: 10, description: "", images: [""], creationAt: "", updatedAt: "", category: Category(id: 2, name: "", image: "", creationAt: "", updatedAt: "")))
}

@ViewBuilder
private func tempAsyncImage(url: URL) -> some View {
    AsyncImage(url: url) { phase in
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
    .frame(width: 80, height: 80)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .padding()
}

