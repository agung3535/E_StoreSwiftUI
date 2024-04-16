//
//  AuthService.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation


protocol AuthServiceProtocol {
    func register(source: UserRequestModel) async throws -> UserModel
    func login(email: String, password: String) async throws -> AccessToken
    func getProfile() async throws -> UserModel?
}


class AuthService: AuthServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    
    func register(source: UserRequestModel) async throws -> UserModel {
        
        guard let apiUrl = APIUrl.Endpoint.users.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(source)
        
        let data = try await networkManager.postData(with: request)
        
        let response = try JSONDecoder().decode(UserModel.self, from: data)
        
        return response
        
    }
    
    func login(email: String, password: String) async throws -> AccessToken {
        guard let apiUrl = APIUrl.Endpoint.login.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let data = try await networkManager.postData(with: request)
        
        let response = try JSONDecoder().decode(AccessToken.self, from: data)
        return response
    }
    
    func getProfile() async throws -> UserModel? {
        guard let apiUrl = APIUrl.Endpoint.profile.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.accessToken.rawValue) ?? ""
        print("token = \(token)")
        var request = URLRequest(url: apiUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let response = try await networkManager.postData(with: request)
            let result = try JSONDecoder().decode(UserModel.self, from: response)
            return result
        }catch {
            print("error get profile = \(error)")
        }
        
        return nil
    }
    
}
