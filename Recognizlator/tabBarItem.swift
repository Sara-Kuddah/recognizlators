//
//  tabBarItem.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//


import Foundation

enum TabBarItem: CaseIterable {
    case imageRec
    case textRec
    case History
   
    
    var title: String {
        switch self {
        case .imageRec:   return NSLocalizedString("Image Rec", comment: "")
        case .textRec:     return NSLocalizedString("Text Rec", comment: "")
        case .History:   return NSLocalizedString("History", comment: "")
        }
    }
    
    var imageName: String {
        switch self {
        case .imageRec:   return "photo"
        case .textRec:     return "doc.plaintext"
        case .History:   return "doc.richtext"
 
        }
    }
}
