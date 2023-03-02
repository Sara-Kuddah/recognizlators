//
//  ContentView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//

import SwiftUI


struct ContentView: View {
    @State var selectedTab: TabBarItem = .imageRec
    var body: some View {
        VStack
        {
          
            HStack{
               // Divider()
                switch selectedTab {
                case .imageRec:
                    ImageRecView(viewModel: ViewModel())
               // case .textRec:
              //    TextRecView(viewModel: ViewModel())
                case .History:
                    HistoryView()
                }
            }
//            Spacer()
//            Divider()
            
            TabBarView(tabs: TabBarItem.allCases, selectedTab: $selectedTab)
          
        }
        .padding(.bottom,-30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 1
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
            // 2
            ContentView()
                .environment(\.locale, .init(identifier: "ar"))
        }
    }
}

