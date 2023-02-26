//
//  LanguageButtonsView.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 06/08/1444 AH.
//

import SwiftUI

struct LanguageButtonsView: View {
    
    @ObservedObject var viewModel: ViewModel
    // Instances of objects
    @State var viewedLanguages = ViewedLanguages()
    
    // Decides whether to present modal sheet or not
    @Binding var isPresented: Bool
    var body: some View {
        HStack {
            
            // First (left) button: English by default
            Button(action: {
                // Passes to modal sheet that button 1 is being called
                viewedLanguages.selection = 1
                isPresented.toggle()
                
            }, label: {
                Text(viewedLanguages.firstName)
                    .bold()
                    .frame(width: 150, height: 40, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(.blue)
            })
            
            // Switch (middle) button: switches languages between first and second button
            Button(action: {
                let temp = viewedLanguages.firstName
                viewedLanguages.firstName = viewedLanguages.secondName
                viewedLanguages.secondName = temp
                
                let temp2 = viewedLanguages.firstCode
                viewedLanguages.firstCode = viewedLanguages.secondCode
                viewedLanguages.secondCode = temp2
                
                let temp3 = viewModel.input
                viewModel.input = viewModel.translation
                viewModel.translation = temp3
                
            }, label: {
                Image(systemName: "arrow.right.arrow.left")
                    .frame(width: 75, height: 40, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor.darkGray))
            })
            
            // Second (right) button: French by default
            Button(action: {
                // Passes to modal sheet that button 2 is being called
                viewedLanguages.selection = 2
                isPresented.toggle()
            }, label: {
                Text(viewedLanguages.secondName)
                    .bold()
                    .frame(width: 150, height: 40, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(.blue)
            })
        }
      
    }
}

//struct LanguageButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageButtonsView(viewModel: ViewModel(), isPresented: false)
//    }
//}
