//
//  UserRequest.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation

struct UserRequestModel: Codable {
    let name: String
    let email: String
    let password: String
    let avatar: String? = "https://picsum.photos/id/202/200/200"
}
