//
//  ContentView.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
  

    var body: some View {
        ZStack {
            NavigationStack {
                LoginPage(vm: LoginViewModel(authService: AuthService()))
            }
        }
    }

    
}


#Preview {
    ContentView()
}
