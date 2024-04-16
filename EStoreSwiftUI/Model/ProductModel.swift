//
//  ProductModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation


struct ProductModel: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let creationAt: String
    let updatedAt: String
    let category: Category
    
    init(id: Int, title: String, price: Int, description: String, images: [String], creationAt: String,updatedAt: String, category: Category) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.images = images
        self.creationAt = creationAt
        self.updatedAt = updatedAt
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "No Title"
        self.price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No Description"
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? [String]()
        self.creationAt = try container.decode(String.self, forKey: .creationAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.category = try container.decode(Category.self, forKey: .category)
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt: String
    let updatedAt: String
    
    init(id: Int, name: String, image: String, creationAt: String, updatedAt: String) {
        self.id = id
        self.name = name
        self.image = image
        self.creationAt = creationAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.creationAt = try container.decode(String.self, forKey: .creationAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}
