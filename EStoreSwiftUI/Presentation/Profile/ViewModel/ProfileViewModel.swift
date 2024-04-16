//
//  ProfileViewModel.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 16/04/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var userData: UserModel?
    @Published var isLoadingProfile = false
    @Published var isLoadProfileSuccess = false
    @Published var isLoadProfileFailed = false
    @Published var isLogout = false
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
    }
    
    
    func getProfile() {
        isLoadingProfile = true
        Task {
            do {
                userData = try await service.getProfile()
                isLoadingProfile = false
                isLoadProfileSuccess = true
            }catch {
                isLoadingProfile = false
                isLoadProfileFailed = true
                print("error get profile = \(error)")
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.accessToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.refreshToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.isLogin.rawValue)
        isLogout = true
    }
    
}
