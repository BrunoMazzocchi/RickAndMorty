//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Bruno Mazzocchi on 18/11/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
