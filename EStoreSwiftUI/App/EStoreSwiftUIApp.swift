//
//  EStoreSwiftUIApp.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 21/03/24.
//

import SwiftUI

@main
struct EStoreSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
