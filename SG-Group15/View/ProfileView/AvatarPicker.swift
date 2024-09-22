
//
//  AvatarPicker.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

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
