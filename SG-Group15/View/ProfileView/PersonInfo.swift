//
//  Avatar.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

import Foundation
import SwiftUI

struct PersonInfo: View {
    @Binding var selectedAvatar: String
    @State private var showAvaPicker: Bool = false
    // Detect horizontal size class
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            // Layout for Iphone
            VStack {
                Image(selectedAvatar)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                    .clipShape(Capsule())
                    .overlay {
                        Button(action: {
                            showAvaPicker = true
                        }) {
                            Circle()
                                .foregroundStyle(Color.clear)
                        }
                    }
                VStack(alignment: .center, spacing: 5) {
                    Text("Username")
                        .foregroundStyle(Color.textDark)
                        .modifier(TitleTextModifier())
                    Text("Member since 20/6/2024")
                        .foregroundStyle(Color.textDark)
                        .modifier(SubHeadlineTextModifier())
                }
            }
            .sheet(isPresented: $showAvaPicker) {
                AvatarPicker(selectedAvatar: $selectedAvatar, showPicker: $showAvaPicker)
                    .presentationDetents([.medium, .height(200)])
            }
        }
        else {
            // Layout for Ipad
            VStack {
                Image(selectedAvatar)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25)
                    .clipShape(Capsule())
                    .overlay {
                        Button(action: {
                            showAvaPicker = true
                        }) {
                            Circle()
                                .foregroundStyle(Color.clear)
                        }
                        
                    }
                VStack(alignment: .center, spacing: 5) {
                    Text("Username")
                        .modifier(HeadlineTextModifierIpad())
                    Text("Member since 20/6/2024")
                        .modifier(SubHeadlineTextModifierIpad())
                }
            }
            // Popover to display avatar picker
            .popover(isPresented: $showAvaPicker, arrowEdge: .bottom) {
                AvatarPicker(selectedAvatar: $selectedAvatar, showPicker: $showAvaPicker)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.6)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                
            }
        }
        
        
    }
}

#Preview {
    PersonInfo(selectedAvatar: .constant("avatar1"))
}
