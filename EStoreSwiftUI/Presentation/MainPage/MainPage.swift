//
//  MainPage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 12/04/24.
//

import SwiftUI

struct MainPage: View {
    
    var body: some View {
        TabView {
            HomePage(
                vm: HomeViewModel(
                    homeService: HomeService(),
                    categoryService: CategoryService()
                ))
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            AddPage()
                .tabItem {
                    Label("", systemImage: "plus.circle.fill")
                }
            ProfilePage(
                vm: ProfileViewModel(service: AuthService())
            )
                .tabItem {
                    Label("", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    MainPage()
}
