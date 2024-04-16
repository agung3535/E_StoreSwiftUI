//
//  LoginViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation


@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var isLoginSuccess = false
    @Published var isLoginFailed = false
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(email: String, password: String) {
        Task {
            do {
                let data =  try await authService.login(email: email, password: password)
                UserDefaults.standard.setValue(data.accessToken, forKey: UserDefaultKey.accessToken.rawValue)
                UserDefaults.standard.setValue(data.refreshToken, forKey: UserDefaultKey.refreshToken.rawValue)
                UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isLogin.rawValue)
                isLoginSuccess = true
            }catch {
                print("error login: \(error)")
                isLoginFailed = true
            }
        }
    }
    
    
}
