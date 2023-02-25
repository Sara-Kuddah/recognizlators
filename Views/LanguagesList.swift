//
//  LanguagesList.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import Foundation
import SwiftUI

// Modal sheet that displays available languages
struct LanguagesList: View {
    
    @Binding var viewedLanguages: ViewedLanguages   // Variables for buttons
    @Binding var isPresented: Bool      // Toggles whether modal sheet is presented or not
    @State var names: [String] = []     // Name of language (i.e. English)
    @State var codes: [String] = []     // Code of language (i.e. en)
    
    let screen = UIScreen.main.bounds

    var body: some View {
        
        VStack {
            
//MARK: - Header
            ZStack {
                Rectangle()
                    .frame(width: screen.width, height: screen.height * 0.075, alignment: .top)
                    .foregroundColor(Color(UIColor.systemGray6))
                HStack {
                    Text("Translate from")
                        .foregroundColor(.black)
                        .bold()
                        .padding(20)
                        .font(.system(size: 22))
                    Spacer()
                    Button(action: {
                        self.isPresented = false
                    }, label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .padding(.all, 15)
                    })
                }
            }

//MARK: - List of Available Languages
            ScrollView {
                ForEach(names.indices, id: \.self) { index in
                    HStack {
                        Button(action: {

                            if viewedLanguages.selection == 1 {
                                // Changes language of button 1
                                viewedLanguages.firstName = names[index]
                                viewedLanguages.firstCode = codes[index]
                                
                            } else if viewedLanguages.selection == 2 {
                                // Changes language of button 2
                                viewedLanguages.secondName = names[index]
                                viewedLanguages.secondCode = codes[index]
                            }
                            
                            // Dismisses modal sheet
                            self.isPresented = false
                        }, label: {
                            Text(names[index])
                                .bold()
                                .foregroundColor(.black)
                                .padding(.leading, 30)
                            Spacer()
                        })
                        .frame(width: screen.width, height: screen.height * 0.07, alignment: .center)
                        .border(Color.gray, width: 0.23)
                        
                    }
                    
                } .onAppear() {
                    // Calls API in getLanguages to get a list of available languages
                    ViewModel().getLanguages { (results) in
                        for result in results.data.languages {
                            names.append(result.name)
                            codes.append(result.language)
                        }
                    }
                }
            }
        }
    }
}

