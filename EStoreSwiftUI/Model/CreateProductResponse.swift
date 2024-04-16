//
//  CreateProductResponse.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation


struct CreateProductResponse: Codable {
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let category: Category
    let id: Int
    let creationAt, updatedAt: String
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Int.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        self.images = try container.decode([String].self, forKey: .images)
        self.category = try container.decode(Category.self, forKey: .category)
        self.id = try container.decode(Int.self, forKey: .id)
        self.creationAt = try container.decode(String.self, forKey: .creationAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
    
}
