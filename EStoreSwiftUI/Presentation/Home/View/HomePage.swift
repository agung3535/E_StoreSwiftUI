//
//  HomePage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct HomePage: View {
    @StateObject var vm: HomeViewModel
    @State var selectedCat: Int = 0
    @State var searchItem: String = ""
    @State var minPrice: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                HeadBarView(
                    searchItem: $searchItem, minPrice: $minPrice,
                    vm: vm, category: $selectedCat
                )
                CategoryView(
                    list: vm.categoryList,
                    selectedCat: $selectedCat
                )
                ListProductView(
                    list: vm.productList,
                    vm: vm
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                Spacer()
            }
            .onAppear {
                vm.fetchCategories()
                vm.fetchProduct(category: selectedCat)
            }
            .onChange(of: selectedCat, { oldValue, newValue in
                vm.fetchProductByFilter(name: searchItem, price: minPrice,category: selectedCat)
            })
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

#Preview {
    HomePage(
        vm: HomeViewModel(
            homeService: HomeService(),
            categoryService: CategoryService()
        ))
}
