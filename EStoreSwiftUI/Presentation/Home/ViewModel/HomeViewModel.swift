//
//  HomeViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    
    @Published var productList: [ProductModel] = []
    
    @Published var categoryList: [CategoryModel] = []
    
    @Published var isLoadProduct: Bool = false
    
    @Published var isLoadCategories: Bool = false
    
    @Published var isLoadProductFailed = false
    
    @Published var isLoadCategoriesFailed = false
    
    @Published var isLoadingDelete = false
    
    @Published var isDeleteProductSuccess = false
    
    @Published var deleteProductFailed = false
    
    @Published var singleProduct: ProductModel?
    
    private let homeService: HomeServiceProtocol
    
    private let categoryService: CategoryServiceProtocol
    
    init(homeService: HomeServiceProtocol, categoryService: CategoryServiceProtocol) {
        self.homeService = homeService
        self.categoryService = categoryService
    }
    
    func fetchProduct(category: Int = -1) {
        productList.removeAll()
        isLoadProduct = true
        Task {
            do {
                if category != 0 {
                    productList = try await homeService.fetchProductByCategory(catId: category)
                }else {
                    productList = try await homeService.fetchAllProduct()
                }
               
                isLoadProduct = false
            }catch {
                isLoadProductFailed = true
            }
        }
    }
    
    func fetchProductByFilter(name: String, price: String, category: Int) {
        productList.removeAll()
        isLoadProduct = true
        Task {
            do {
                productList = try await homeService.fetchProductByFilter(name: name, price: price, category: category)
                isLoadProduct = false
            }catch {
                isLoadProductFailed = true
            }
        }
    }
    
    func fetchCategories() {
        isLoadCategories = true
        Task {
            do {
                categoryList = try await categoryService.fetchAllCategory()
                isLoadCategories = false
            }catch {
                isLoadCategoriesFailed = true
            }
        }
    }
    
    func deleteProduct(id: Int) {
        isLoadingDelete = true
        Task {
            do {
                isDeleteProductSuccess = try await homeService.deleteProduct(id: id)
            }catch {
                deleteProductFailed = true
            }
        }
    }
    
    func detailProduct(id: Int) {
        Task {
            do {
                singleProduct = try await homeService.getDetailProduct(id: id)
            }catch {
                print("error detail \(error)")
            }
        }
    }
    
    
}
