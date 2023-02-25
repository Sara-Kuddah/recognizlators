//
//  HomeView.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import SwiftUI
//import CoreData

// Button variables
struct ViewedLanguages: Hashable, Equatable {
    var firstName: String = "English"       // Name of language on first button
    var firstCode: String = "en"            // Code of first button's language for API call
    var secondName: String = "French"       // Name of language on second button
    var secondCode: String = "fr"           // Code of second button's language for API call
    var selection: Int = 0                  // Decides whether the first or second button has been pressed
}

// Variables that WILL be saved to Core Data
struct Translation {
    var input: String = ""
    var translation: String = ""
    var star: Bool = false
}

// Handles translations (API calls) and saving data to Core Data; the REAL main view of the app
struct HomeView: View {
    
    // Core Data
    //    @Environment(\.managedObjectContext) private var context
    //    @FetchRequest(entity: SavedTranslations.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedTranslations.time, ascending: true)])
    //    var savedTranslations: FetchedResults<SavedTranslations>
    
    // View Model
    @ObservedObject var viewModel: ViewModel
    
    // Instances of objects
    @State var viewedLanguages = ViewedLanguages()
    @State var translation = Translation()
    
    // Decides whether to present modal sheet or not
    @State var isPresented: Bool = false
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        
        VStack {
            
            //MARK: - Header
            ZStack {
                Rectangle()
                    .frame(width: screen.width, height: screen.height * 0.075, alignment: .top)
                    .foregroundColor(.blue)
                Text("Google Translate Clone")
                    .foregroundColor(.white)
                    .bold()
            }
            
            //MARK: - Buttons
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
            
            //MARK: - Text Fields
            VStack (spacing: -10) {
                
                // Top text field: where user enters input to be translated
                ZStack {
                    TextField("Enter text", text: $viewModel.input)
                        .frame(width: screen.width * 0.925, height: screen.height * 0.1, alignment: .top)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .border(Color(UIColor.systemGray2), width: 1)
                    HStack {
                        Spacer()
                        
                        // Delete button: deletes any input entered by user
                        Button(action: {
                            viewModel.input = ""
                        }, label: {
                            Image(systemName: "multiply")
                                .frame(width: 25, height: 25, alignment: .center)
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }).padding(.trailing, 15)
                    }
                }
                
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
                            if !viewModel.input.isEmpty {
                                // Calls API translate function to retrieve translation
                                ViewModel().translate(for: viewModel.input, for: viewedLanguages.firstCode, for: viewedLanguages.secondCode) { (results) in
                                    viewModel.translation = results.data.translations.first?.translatedText ?? "default value"
                                }
                                
                                // Waits 4 seconds after button has been pressed before saving to Core Data
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    if !viewModel.translation.isEmpty {
                                        translation.input = viewModel.input
                                        translation.translation = viewModel.translation
//                                        save(translation: translation)
                                    }
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
            
            //MARK: - List of Translations: a history of translations that were made and saved to Core Data
            //            ScrollView {
            //                ForEach(savedTranslations, id: \.self) { savedItem in
            //                    HStack {
            //                        VStack {
            //                            Text("\(savedItem.input!)")
            //                                .bold()
            //                                .foregroundColor(.black)
            //                                .font(.system(size: 17))
            //                                .padding(.leading, 20)
            //                            Text("\(savedItem.translation!)")
            //                                .bold()
            //                                .foregroundColor(Color(UIColor.systemGray))
            //                                .font(.system(size: 13))
            //                                .padding(.leading, 25)
            //                        }
            //
            //                        Spacer()
            //
            //                        // Star button: allows user to add translations to a favorites list, toggles star variable in Core Data
            //                        Button(action: {
            //                            savedItem.star.toggle()
            //                            star(savedItem: savedItem, starStatus: savedItem.star)
            //
            //                        }, label: {
            //                            Image(systemName: savedItem.star ? "star.fill" : "star")
            //                                .font(.system(size: 17))
            //                                .foregroundColor(savedItem.star ? .yellow : .black)
            //                                .padding(.trailing, 15)
            //                        })
            //                    }
            //                    .frame(width: screen.width * 0.98, height: screen.height * 0.08, alignment: .center)
            //                    .border(Color.gray, width: 0.23)
            //                    .background(Color.white)
            //                    .onLongPressGesture {
            //                        // Deletes translation from Core Data with a long tap gesture
            //                        delete(savedItem: savedItem)
            //                    }
            //
            //                }
            //            }.background(Color(UIColor.systemGray6).opacity(20))
            //        }.sheet(isPresented: $isPresented) {
            //            // Modal sheet of available languages
            //            LanguagesList(viewedLanguages: $viewedLanguages, isPresented: $isPresented)
            //        }
            //    }
            
            // Adds item to Core Data
            //    private func save(translation: Translation) {
            //        withAnimation {
            //            let newItem = SavedTranslations(context: context)
            //            newItem.input = translation.input
            //            newItem.translation = translation.translation
            //            newItem.star = translation.star
            //            newItem.time = Date()
            //
            //            do {
            //                try context.save()
            //            } catch {
            //                print(error.localizedDescription)
            //            }
            //        }
            //    }
            
            // Toggles an item's star variable in Core Data
            //    func star(savedItem: SavedTranslations, starStatus: Bool) {
            //        withAnimation {
            //            savedItem.star = starStatus
            //
            //            do {
            //                try context.save()
            //            } catch {
            //                print(error.localizedDescription)
            //            }
            //        }
            //    }
            
            // Deletes item from Core Data
            //    private func delete(savedItem: SavedTranslations) {
            //        withAnimation {
            //            context.delete(savedItem)
            //
            //            do {
            //                try context.save()
            //            } catch {
            //                print(error.localizedDescription)
            //            }
            //        }
            //    }
        }
        
    }}
