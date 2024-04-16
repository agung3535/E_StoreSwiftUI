//
//  CategoryService.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation


protocol CategoryServiceProtocol {
    func fetchAllCategory() async throws -> [CategoryModel]
    func createCategory(name: String, image:String) async throws -> CategoryModel?
    func deleteCategory(id: Int) async throws -> Bool
    func updateCategory(id: Int, name: String?, image: String?) async throws -> CategoryModel?
}


class CategoryService: CategoryServiceProtocol {
    
    
    private let networkManager = NetworkManager.shared
    
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
    
    func createCategory(name: String, image: String) async throws -> CategoryModel? {
        guard let apiUrl = APIUrl.Endpoint.categories.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var payload: Data?
        
        let bodyReq = CategoryRequest(name: name, image: image)
        
        do {
            payload = try JSONEncoder().encode(bodyReq)
        }catch {
            print("error encode \(error)")
        }
        
        var req = URLRequest(url: apiUrl)
        req.httpMethod = HTTPMethod.post.rawValue
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = payload
        
        do {
            let dataResult = try await networkManager.postData(with: req)
            let result = try JSONDecoder().decode(CategoryModel.self, from: dataResult)
            return result
        }catch {
            print("error post data = \(error)")
        }
        
        return nil
        
    }
    
    func deleteCategory(id: Int) async throws -> Bool {
        guard let apiUrl = APIUrl.Endpoint.deleteCategories(id).fullURLEndpoint() else {
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
    
    func updateCategory(id: Int, name: String?, image: String?) async throws -> CategoryModel? {
        guard let apiUrl = APIUrl.Endpoint.updateCategories(id).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var payload: Data?
        
        let bodyReq = CategoryRequest(
            name: name ?? nil,
            image: image ?? nil
        )
        
        do {
            payload = try JSONEncoder().encode(bodyReq)
        }catch {
            print("error encode: \(error)")
        }
        
//        print("data payload = \( try JSONDecoder().decode(CategoryModel.self, from: payload!))")
        let json = String(data: payload!, encoding: String.Encoding.utf8)
        print("json = \(json)")

        
        var req = URLRequest(url: apiUrl)
        req.httpMethod = HTTPMethod.put.rawValue
        req.httpBody = payload
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let response = try await networkManager.postData(with: req)
            let result = try JSONDecoder().decode(CategoryModel.self, from: response)
            return result
        }catch {
            print("error post data = \(error)")
        }
        
        return nil
    }
    
}
