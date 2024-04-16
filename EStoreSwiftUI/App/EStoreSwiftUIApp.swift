//
//  EStoreSwiftUIApp.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI

@main
struct EStoreSwiftUIApp: App {
    @StateObject private var authManager = AuthManager()
    let persistenceController = PersistenceController.shared
    let isLogin = UserDefaults.standard.bool(forKey: UserDefaultKey.isLogin.rawValue)

    var body: some Scene {
        WindowGroup {
            if authManager.isLoggedIn {
                MainPage()
                    .environmentObject(authManager)
            }else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authManager)
            }
        }
    }
}
