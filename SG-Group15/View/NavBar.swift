//
//  NavBar.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct NavBar: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @Binding var selected: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "menucard")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .onTapGesture {
                    selected = "menu"
                }
                .foregroundColor(selected == "menu" ? .darkRed : .black)
            
            Spacer()
            
            Image(systemName: "note.text")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .onTapGesture {
                    selected = "note"
                }
                .foregroundColor(selected == "note" ? .darkRed : .black)
            
            Spacer()
            
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .onTapGesture {
                    selected = "setting"
                }
                .foregroundColor(selected == "setting" ? .darkRed : .black)
            
            Spacer()
        }
    }
}

//#Preview {
//    NavBar()
//}
