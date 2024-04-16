//
//  UserModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation

struct UserModel: Codable {
    
    let email,password: String
    let name,avatar,role: String
    let id: Int
    
    enum CodingKeys: CodingKey {
        case email
        case password
        case name
        case avatar
        case role
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.role = try container.decodeIfPresent(String.self, forKey: .role) ?? ""
        self.id = try container.decode(Int.self, forKey: .id)
    }
    
}
