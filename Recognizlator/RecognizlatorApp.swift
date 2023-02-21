//
//  RecognizlatorApp.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//

import SwiftUI

@main
struct RecognizlatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           
            
            OnBoardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
