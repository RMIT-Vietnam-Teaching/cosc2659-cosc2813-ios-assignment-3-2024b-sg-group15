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

import Foundation
import SwiftUI

struct PersonInfo: View {
    @Binding var selectedAvatar: String
    @State private var showAvaPicker: Bool = false
    @EnvironmentObject var userVM: UserViewModel
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
                    Text(userVM.currentUser?.username ?? "Username")
                        .foregroundStyle(Color.textDark)
                        .modifier(TitleTextModifier())
                    
                    if let joinedAt = userVM.currentUser?.joinedAt {
                        Text("Member since \(joinedAt)")
                            .foregroundStyle(Color.textDark)
                            .modifier(SubHeadlineTextModifier())
                    }
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
                    Text(userVM.currentUser?.username ?? "Username")
                        .foregroundStyle(Color.textDark)
                        .modifier(TitleTextModifierIpad())
                    if let joinedAt = userVM.currentUser?.joinedAt {
                        Text("Member since: \(formatDate(joinedAt))")  // Format the date inline
                            .foregroundStyle(Color.textDark)
                            .modifier(SubHeadlineTextModifierIpad())
                    }
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
    
    // Function to format the date
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full  // Outputs "Monday, September 23, 2024"
        return formatter.string(from: date)
    }
}

#Preview {
    PersonInfo(selectedAvatar: .constant("avatar1"))
}
