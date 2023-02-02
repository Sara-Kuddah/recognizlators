//
//  recognizlatorsApp.swift
//  recognizlators
//
//  Created by Sara Khalid BIN kuddah on 11/07/1444 AH.
//

import SwiftUI

@main
struct recognizlatorsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
