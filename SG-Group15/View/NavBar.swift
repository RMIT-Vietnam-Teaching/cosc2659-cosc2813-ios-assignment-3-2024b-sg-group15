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
                .foregroundColor(selected == "menu" ? .darkRed : .blackCustom)
            
            Spacer()
            
            Image(systemName: "note.text")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .onTapGesture {
                    selected = "note"
                }
                .foregroundColor(selected == "note" ? .darkRed : .blackCustom)
            
            Spacer()
            
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .onTapGesture {
                    selected = "setting"
                }
                .foregroundColor(selected == "setting" ? .darkRed : .blackCustom)
            
            Spacer()
        }
    }
}

//#Preview {
//    NavBar()
//}
