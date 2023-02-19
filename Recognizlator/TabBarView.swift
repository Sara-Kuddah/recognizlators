//
//  TabBarView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//


import SwiftUI

struct TabBarView: View {
    
    var tabs: [TabBarItem]
    @Binding var selectedTab: TabBarItem
    
    var body: some View {
        
            HStack(spacing: 20) {
                Spacer()
                ForEach(tabs, id: \.self) { tab in
                    TabBarItemView(type: tab, selectedTab: $selectedTab)
                    Spacer()
                }
            }
            .background(CustomColorz.myColor)
    }
}

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("CusColor")
}


struct CustomColorz {
    static let myColor = Color(("Color"))
    // Add more here...
}

extension Color {
    static let olaadPrimaryColor = Color(UIColor.systemIndigo)
    static let neewPrimaryColorq = Color("LightGray")
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(tabs: TabBarItem.allCases, selectedTab: .constant(.imageRec))
    }
}
