//
//  TabBarItemView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//

import SwiftUI

struct TabBarItemView: View {
    
    var type: TabBarItem
    @Binding var selectedTab: TabBarItem
    
    var isSelected: Bool {
        return selectedTab == type
    }
    
    var body: some View {
        ZStack{
              Spacer()
            GeometryReader.init(content: { geometry in
                Button(action: {
                    selectedTab = type
                }, label: {
                    VStack {
                        Spacer()
                        Image(systemName: type.imageName + (isSelected ? ".fill" : "")).font(.system(size:25)).bold()
                        Text(type.title)
                            .font(Font.custom("SF Pro", size: 13))
                    }
                })
                .frame( width: 70, height: 50)
                .foregroundColor(isSelected ? .newPrimaryColorq : .newPrimaryColorw)
            })
            .frame(width: 75, height: 60)
        }
        
    }
}

extension Color {
    static let olldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColorw = Color("Gray")
}

extension Color {
    static let oladPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColorq = Color("CusColor")
}


struct TabBarViewItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 1
            TabBarItemView(type: .History, selectedTab: .constant(.History))
                .environment(\.locale, .init(identifier: "en"))
            // 2
            TabBarItemView(type: .History, selectedTab: .constant(.History))
                .environment(\.locale, .init(identifier: "ar"))
        }
        
    }
}
