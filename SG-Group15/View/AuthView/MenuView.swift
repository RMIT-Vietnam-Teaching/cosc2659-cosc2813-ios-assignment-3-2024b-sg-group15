//
//  MenuView.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userViewModel:  UserViewModel

    @State var selected: String = "menu"
    @State private var isOpen: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                if selected == "menu" {
                    BookMenuView(isOpen: $isOpen)
                } else if selected == "note" {
                    NoteListView()
                } else if selected == "setting" {
                    MyProfileView()
                }
            }
            
            if !isOpen {
                NavBar(selected: $selected)
            }  
        }
    }
}

#Preview {
    MenuView()
}
