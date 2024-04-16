//
//  HomeService.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchAllProduct() async throws -> [ProductModel]
    func fetchAllCategory() async throws -> [CategoryModel]
    func fetchProductByCategory(catId: Int) async throws -> [ProductModel]
    func fetchProductByFilter(name: String, price: String, category: Int) async throws -> [ProductModel]
    func deleteProduct(id: Int) async throws -> Bool
    func getDetailProduct(id: Int) async throws -> ProductModel?
    
}

class HomeService: HomeServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    
    func fetchAllProduct() async throws -> [ProductModel] {
        guard let apiUrl = APIUrl.Endpoint.product.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try await networkManager.fetchData(from: apiUrl)
            let response = try JSONDecoder().decode([ProductModel].self, from: data)
            return response
        }catch {
            print("error get product = \(error.localizedDescription)")
        }
        
       return []
    }
    
    func fetchAllCategory() async throws -> [CategoryModel] {
        guard let apiUrl = APIUrl.Endpoint.categories.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        do {
            let data = try await networkManager.fetchData(from: apiUrl)
            let response = try JSONDecoder().decode([CategoryModel].self, from: data)
            return response
        } catch {
            print("error get categories = \(error.localizedDescription)")
        }
        
        return []
    }
    
    func fetchProductByCategory(catId: Int) async throws -> [ProductModel] {
        guard let apiUrl = APIUrl.Endpoint.productsByCategory(catId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        do {
            let data = try await networkManager.fetchData(from: apiUrl)
            let response = try JSONDecoder().decode([ProductModel].self, from: data)
            return response
        }catch {
            print("error get product = \(error.localizedDescription)")
        }
        
        return []
    }
    
    func fetchProductByFilter(name: String, price: String, category: Int) async throws -> [ProductModel] {
        
        guard let apiUrl = APIUrl.Endpoint.productsByFilter(name, price, category).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        do {
            let data = try await networkManager.fetchData(from: apiUrl)
            let response = try JSONDecoder().decode([ProductModel].self, from: data)
            return response
        }catch {
            print("error get product by filter = \(error.localizedDescription)")
        }
        
        return []
    }
    
    func deleteProduct(id: Int) async throws -> Bool {
        guard let apiUrl = APIUrl.Endpoint.deleteProduct(id).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var req = URLRequest(url: apiUrl)
        req.httpMethod = HTTPMethod.delete.rawValue
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try await networkManager.postData(with: req)
            let response = try JSONDecoder().decode(Bool.self, from: data)
            return response
        }catch {
            print("Error delete : \(error)")
        }
        
        return false
    }
    
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
