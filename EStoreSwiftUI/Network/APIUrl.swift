//
//  APIUrl.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation


struct APIUrl {
    static let baseURL = "https://api.escuelajs.co/api/"
    static let apiVersion = "v1"
    
    enum Endpoint {
        case users
        case productsByCategory(Int)
        case createProduct
        case uploadFile
        case deleteProduct(Int)
        case login
        case product
        case categories
        case productsByFilter(String,String,Int)
        case updateProducts(Int)
        case detail(Int)
        case deleteCategories(Int)
        case updateCategories(Int)
        case profile
        
        func path() -> String {
            switch self {
            case .users:
                return "users"
            case .productsByCategory(let categoryId):
                return "categories/\(categoryId)/products"
            case .createProduct:
                return "products/"
            case .uploadFile:
                return "files/upload"
            case .deleteProduct(let productId):
                return "products/\(productId)"
            case .login:
                return "auth/login"
            case .product:
                return "products"
            case .categories:
                return "categories"
            case .productsByFilter(let name, let price, let category):
                return "products/?title=\(name)&price=\(price)&categoryId=\(category)"
            case .updateProducts(let id):
                return "products/\(id)"
            case .detail(let id):
                return "products/\(id)"
            case .deleteCategories(let id):
                return "categories/\(id)"
            case .updateCategories(let id):
                return "categories/\(id)"
            case .profile:
                return "auth/profile"
            }
        }
        
        func fullURLEndpoint() -> URL? {
            let fullURL = URL(string: "\(baseURL)\(apiVersion)/\(self.path())")
            return fullURL
        }
    }

}
