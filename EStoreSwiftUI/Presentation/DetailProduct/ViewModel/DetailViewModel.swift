//
//  DetailViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation

@MainActor
class DetailViewModel: ObservableObject {
    
    
    @Published var singleProduct: ProductModel?
    
    private let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    func detailProduct(id: Int) {
        print("product id = \(id)")
        Task {
            do {
                singleProduct = try await productService.getDetailProduct(id: id)
            }catch {
                print("error detail \(error)")
            }
        }
    }
    
}
