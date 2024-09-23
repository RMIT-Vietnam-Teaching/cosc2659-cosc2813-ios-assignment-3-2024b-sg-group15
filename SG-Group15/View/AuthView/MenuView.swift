/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 15
    - Nguyen Tran Ha Anh - 3938490
    - Bui Tuan Anh - 3970375
    - Nguyen Ha Kieu Anh - 3818552
    - Truong Hong Van - 3957034
  Created  date: 08/09/2024
  Last modified: 23/09/2024
*/

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
