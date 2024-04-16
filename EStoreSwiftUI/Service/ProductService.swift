//
//  ProductService.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation


protocol ProductServiceProtocol {
    func getDetailProduct(id: Int) async throws -> ProductModel?
}

class ProductService: ProductServiceProtocol {
    
    let networkManager = NetworkManager.shared
    
    
    func getDetailProduct(id: Int) async throws -> ProductModel? {
        guard let apiUrl = APIUrl.Endpoint.detail(id).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        do {
            let data = try await networkManager.fetchData(from: apiUrl)
            let response = try JSONDecoder().decode(ProductModel.self, from: data)
            return response
        }catch {
            print("get Detail : \(error)")
        }
        
        return nil
    }
    
}
