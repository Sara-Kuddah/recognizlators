//
//  MainView.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import Foundation
import SwiftUI

struct MainView: View {
        
    // Core Data instances to pass to StarView
//    @FetchRequest(entity: SavedTranslations.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedTranslations.time, ascending: true)])
//    var savedTranslations: FetchedResults<SavedTranslations>
    
    // ViewModel instance to pass to HomeView
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        

            HomeView(viewModel: viewModel)

    }
}

struct MainView_Previews: PreviewProvider {
   
    static var previews: some View {
        MainView(viewModel: ViewModel())
    }
}

