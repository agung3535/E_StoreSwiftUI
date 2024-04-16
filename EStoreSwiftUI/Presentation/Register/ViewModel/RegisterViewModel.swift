//
//  RegisterViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import SwiftUI


@MainActor
class RegisterViewModel: ObservableObject {
    
    
    @Published var isRegistered: Bool = false
    @Published var failedRegister: Bool = false
    
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func register(name: String, email: String, password: String) {
        let userReq = UserRequestModel(name: name, email: email, password: password)

        Task {
            do {
                try await authService.register(source: userReq)
                DispatchQueue.main.async {
                    self.isRegistered = true
                }
            }catch {
                print("error = \(error)")
                failedRegister = true
            }
        }
    }
    
    
    
}
