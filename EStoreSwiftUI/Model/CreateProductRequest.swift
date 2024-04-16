//
//  CreateProductRequest.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation


struct CreateProductRequest: Codable {
    
    let title: String?
    let price: Int?
    let description: String?
    let categoryId: Int?
    let images: [String]?
    
}
