//
//  ListProductView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct ListProductView: View {
    var list: [ProductModel] = []
    var vm: HomeViewModel
    var body: some View {
        List {
            ForEach(list, id: \.id) { data in
                NavigationLink {
                    DetailProductPage(product: data, detailVM: DetailViewModel(productService: ProductService()))
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    ListProductItem(product: data)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive, action: { 
                                vm.deleteProduct(id: data.id)
                            } ) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }

            }
            
        }
        .listStyle(.plain)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
}

#Preview {
    ListProductView(list: [ProductModel(id: 0, title: "Tes", price: 10, description: "", images: [""], creationAt: "", updatedAt: "", category: Category(id: 2, name: "", image: "", creationAt: "", updatedAt: ""))], vm: HomeViewModel(homeService: HomeService(), categoryService: CategoryService()))
}
