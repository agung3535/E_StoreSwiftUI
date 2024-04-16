//
//  AddProductService.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import UIKit

protocol AddProductServiceProtocol {
    func uploadImage(image: UIImage) async throws -> String
    func createProduct(title: String, price: Int, desc: String, categoryId: Int, images:[String]) async throws -> CreateProductResponse?
    func updateProduct(id:Int, title: String?, price: Int?, desc: String?, categoryId: Int?, images:[String]?) async throws -> CreateProductResponse?
}


class AddProductService: AddProductServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    
    func uploadImage(image: UIImage) async throws -> String {
        do {
            let response = try await networkManager.uploadImage(image: image)
            return response
        }catch {
            print("error upload image: \(error)")
        }
        return ""
    }
    
    func createProduct(title: String, price: Int, desc: String, categoryId: Int, images: [String]) async throws -> CreateProductResponse? {
        guard let apiUrl = APIUrl.Endpoint.createProduct.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let bodyReq = CreateProductRequest(
            title: title,
            price: price,
            description: desc,
            categoryId: categoryId,
            images: images)
        
        var payload: Data?
        
        do {
            payload = try JSONEncoder().encode(bodyReq)
        }catch {
            print("error encode: \(error)")
        }
    
        
        var req = URLRequest(url: apiUrl)
        req.httpMethod = HTTPMethod.post.rawValue
        req.httpBody = payload
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        do {
            let response = try await networkManager.postData(with: req)
            let result = try JSONDecoder().decode(CreateProductResponse.self, from: response)
            return result
        }catch {
            print("error post data = \(error)")
        }
        
        return nil
    }
    
    func updateProduct(id:Int, title: String?, price: Int?, desc: String?, categoryId: Int?, images: [String]?) async throws -> CreateProductResponse? {
        guard let apiUrl = APIUrl.Endpoint.updateProducts(id).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
    
        
        let bodyReq = CreateProductRequest(
            title: title ?? nil,
            price: price ?? nil,
            description: desc ?? nil,
            categoryId: categoryId ?? nil,
            images: images ?? nil)
        
        var payload: Data?
        
        do {
            payload = try JSONEncoder().encode(bodyReq)
        }catch {
            print("error encode: \(error)")
        }
        
        print("data payload = \( try JSONDecoder().decode(CreateProductRequest.self, from: payload!))")
        let json = String(data: payload!, encoding: String.Encoding.utf8)
        print("json = \(json)")

        
        var req = URLRequest(url: apiUrl)
        req.httpMethod = HTTPMethod.put.rawValue
        req.httpBody = payload
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let response = try await networkManager.postData(with: req)
            let result = try JSONDecoder().decode(CreateProductResponse.self, from: response)
            return result
        }catch {
            print("error post data = \(error)")
        }
        
        return nil
        
    }
    
}
