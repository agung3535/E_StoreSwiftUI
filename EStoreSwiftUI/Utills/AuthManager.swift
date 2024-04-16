//
//  AuthManager.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    
    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultKey.isLogin.rawValue)
    }
    
    func login() {
            isLoggedIn = true
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        }
    
    func logout() {
        // Perform logout operations
        isLoggedIn = false
    }
}
