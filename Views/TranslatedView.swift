//
//  TranslatedView.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 06/08/1444 AH.
//

import SwiftUI

struct TranslatedView: View {
    @ObservedObject var viewModel: ViewModel
    // to take input from ML result
    func takeInput(text : String){
        viewModel.input = text
    }
    //MARK: - Header
    let screen = UIScreen.main.bounds
    
    // Instances of objects
    @State var viewedLanguages = ViewedLanguages()
    
    var body: some View {
        ZStack {
            // Second text field: where translation is displayed
            TextField("", text: $viewModel.translation)
                .frame(width: screen.width * 0.925, height: screen.height * 0.1, alignment: .top)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color(UIColor.systemGray2), width: 1)
                .disabled(true)
            HStack {
                Spacer()
                
                // Translate button: passes input to translation API
                Button(action: {
                    takeInput(text: "Hi Sara")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if !viewModel.input.isEmpty {
                            // Calls API translate function to retrieve translation
                            ViewModel().translate(for: viewModel.input, for: viewedLanguages.firstCode, for: viewedLanguages.secondCode) { (results) in
                                viewModel.translation = results.data.translations.first?.translatedText ?? "default value"
                            }
                            
                            // Waits 4 seconds after button has been pressed before saving to Core Data
                            //                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            //                                    if !viewModel.translation.isEmpty {
                            //                                        translation.input = viewModel.input
                            //                                        translation.translation = viewModel.translation
                            ////                                        save(translation: translation)
                            //                                    }
                            //                                }
                        }
                    }
                }, label: {
                    Image(systemName: "arrow.right")
                        .frame(width: 25, height: 25, alignment: .center)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                    
                }).padding(.trailing, 15)
            }
        }
    }
}

struct TranslatedView_Previews: PreviewProvider {
    static var previews: some View {
        TranslatedView(viewModel: ViewModel())
    }
}
