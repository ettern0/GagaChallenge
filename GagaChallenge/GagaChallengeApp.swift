//
//  GagaChallengeApp.swift
//  GagaChallenge
//
//  Created by Евгений Сердюков on 08.11.2021.
//

import SwiftUI

@main
struct GagaChallengeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
