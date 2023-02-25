//
//  StarView.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import Foundation
import SwiftUI

// Displays a list of starred/"favorited" translations stored in Core Data
struct StarView: View {
    
    // Core Data variables
//    @Environment(\.managedObjectContext) private var context
//    var savedTranslations: FetchedResults<SavedTranslations>
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        
        VStack {
            
//MARK: - Header
            ZStack {
                Rectangle()
                    .frame(width: screen.width, height: screen.height * 0.075, alignment: .top)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .border(Color.gray, width: 0.3)
                
                HStack {
                    Text("Saved")
                        .foregroundColor(.black)
                        .bold()
                        .padding(20)
                        .font(.system(size: 22))
                    Spacer()
                }
            }
     
//MARK: - List of starred (saved or favorited) translations: displays Core Data translations that have a "star"
//            ScrollView {
//                ForEach(savedTranslations, id: \.self) { savedItem in
//                    if savedItem.star {
//                        HStack {
//                            VStack {
//                                Text("\(savedItem.input!)")
//                                    .bold()
//                                    .foregroundColor(.black)
//                                    .font(.system(size: 17))
//                                    .padding(.leading, 23)
//                                Text("\(savedItem.translation!)")
//                                    .bold()
//                                    .foregroundColor(Color(UIColor.systemGray))
//                                    .font(.system(size: 13))
//                                    .padding(.leading, 25)
//                            }
//
//                            Spacer()
//
//                            // Star button: allows user to add translations to a favorites list, toggles star variable in Core Data
//                            Button(action: {
//                                savedItem.star.toggle()
//                                star(savedItem: savedItem, starStatus: savedItem.star)
//
//                            }, label: {
//                                Image(systemName: savedItem.star ? "star.fill" : "star")
//                                    .font(.system(size: 17))
//                                    .foregroundColor(savedItem.star ? .yellow : .black)
//                                    .padding(.trailing, 15)
//                            })
//                        }
//                        .frame(width: screen.width * 0.95, height: screen.height * 0.08, alignment: .center)
//                        .background(Color.white)
//                        .border(Color.gray, width: 0.3)
//                        .padding(3)
//                        .shadow(radius: 0.05)
//                    }
//                }
//            }
        }
        .background(Color(UIColor.systemGray6).opacity(20))
    }
    
    // Toggles an item's star variable in Core Data
//    func star(savedItem: SavedTranslations, starStatus: Bool) {
//        withAnimation {
//            print("Starring \(savedItem.input!)")
//
//            savedItem.star = starStatus
//
//            do {
//                try context.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
}

