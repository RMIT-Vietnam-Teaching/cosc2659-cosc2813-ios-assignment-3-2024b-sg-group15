
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

struct AvatarPicker: View {
    @Binding var selectedAvatar: String
    @Binding var showPicker: Bool
    @State private var selected: String = "avatar1"
    // List of avatars
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5"]
    
    // Detect horizontal size class
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
            if horizontalSizeClass == .compact {
                // Layout for iPhone
                VStack(alignment: .center) {
                    Text("Chọn hình đại diện của bạn")
                        .modifier(TitleTextModifier())
                    // Display the avatar
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.15))], spacing: 20) {
                        ForEach(avatars, id: \.self) { avatar in
                            Image(avatar)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                                .background(
                                    selected == avatar ? Color.lightRed : Color.clear
                                )
                                .clipShape(Circle())
                                .onTapGesture {
                                    selected = avatar // Update selected avatar
                                }
                        }
                    }
                    Button(action: {
                        selectedAvatar = selected
                        showPicker = false
                    }) {
                        Text("Lưu")
                            .modifier(RegularButtonModifier(background: Color.primaryRed))
                    }
                }
                
            }
            else {
                VStack(alignment: .center) {
                    // Layout for iPad
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.18))], spacing: 20) {
                        ForEach(avatars, id: \.self) { avatar in
                            Image(avatar)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                                .background(
                                    selected == avatar ? Color.lightRed : Color.clear
                                )
                                .clipShape(Circle())
                                .onTapGesture {
                                    selected = avatar
                                }
                        }
                    }
                    Button(action: {
                        selectedAvatar = selected
                        showPicker = false
                    }) {
                        Text("Lưu")
                            .modifier(RegularButtonModifier(background: Color.primaryRed))
                    }
                }
            }
    }
}
