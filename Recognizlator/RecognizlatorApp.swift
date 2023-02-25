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
    @StateObject var viewModel: ViewModel = ViewModel()
 
    var body: some Scene {
        WindowGroup {
//            MainView(viewModel: viewModel)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            OnBoardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//
