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

struct MyProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var avatar: String = "avatar5"
    @AppStorage("theme") private var theme: Theme = .light
    @Environment(\.colorScheme) private var scheme: ColorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isLoggedOut: Bool = false
    
    private func saveSettings() {
        userViewModel.updatePreferences(
            darkMode: theme == .dark,
            avatar: avatar
        )
        if let currentUser = userViewModel.currentUser {
            print(currentUser)
        }
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.beigeBackground
                    .ignoresSafeArea(.all)
                if horizontalSizeClass == .compact {
                    VStack {
                        Text("Cài đặt")
                            .modifier(TitleTextModifier())
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.1)
                        PersonInfo(selectedAvatar: $avatar)
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.15)
                            ThemePicker(scheme: scheme)
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.2)
                        Button(action: {
                            saveSettings()
                        }) {
                            Text("Lưu")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                                .foregroundColor(.white)
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .primaryRed)) : AnyViewModifier(LargeButtonModifierIpad(background: .primaryRed)))
                            
                        }
                        Button(action: {
                            userViewModel.logout()
                            isLoggedOut = true
                        }) {
                            Text("Đăng xuất")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                                .foregroundColor(.white)
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .darkGreen)) : AnyViewModifier(LargeButtonModifierIpad(background: .darkGreen)))
                            
                        }
                    }
                }
                else {
                    VStack {
                        Text("Cài đặt")
                            .modifier(TitleTextModifierIpad())
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.05)
                        PersonInfo(selectedAvatar: $avatar)
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.1)
                        VStack(alignment: .leading, spacing: 20) {
                            ThemePicker(scheme: scheme)
                            
                        }
                        Spacer()
                            .frame(height: UIScreen.main.bounds.width * 0.1)
                        // Placeholder for error message
                        if userViewModel.success {
                            Text("Update Sucessfully!")
                                .foregroundStyle(Color.green)
                        }
                        // Placeholder for error message
                        if let message = userViewModel.errorMessage {
                            HStack {
                                Image(systemName: "x.circle.fill")
                                    .modifier(BodyTextModifier(color: Color.darkRed))
                                Text(message)
                                    .modifier(BodyTextModifier(color: Color.darkRed))
                            }
                            .padding()
                        }
                        Button(action: {
                            saveSettings()
                        }) {
                            Text("Lưu")
                                .modifier(LargeButtonModifier(background: Color.primaryRed))
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                        }
                        Button(action: {
                            userViewModel.logout()
                            isLoggedOut = true
                            userViewModel.isLogin = false
                        }) {
                            Text("Đăng xuất")
                                .modifier(LargeButtonModifier(background: Color.darkGreen))
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                            
                        }
                    }
                    
                }
            }
            
            .navigationDestination(isPresented: $isLoggedOut) {
                WelcomeView()
            }
        }
        .preferredColorScheme(theme.colorScheme)
        .onAppear {
            if let userAvatar = userViewModel.currentUser?.avatar {
                avatar = userAvatar
            }
        }
        
        
    }
}

#Preview {
    let dummyUser = User(id: "1", username: "Test User", email: "test@example.com", avatar: "avatar1", darkMode: false)
    let userVM = UserViewModel()
    userVM.currentUser = dummyUser
    
    return MyProfileView()
        .environmentObject(UserViewModel())
    
}
