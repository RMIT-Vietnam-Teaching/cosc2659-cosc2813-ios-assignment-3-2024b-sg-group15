//
//  MyProfileView.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

import Foundation
import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @EnvironmentObject var userVM: UserViewModel
    @State private var avatar: String = "avatar5"
    @AppStorage("theme") private var theme: Theme = .light
    @Environment(\.colorScheme) private var scheme: ColorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private func saveSettings() {
        userVM.updatePreferences(
            darkMode: theme == .dark,
            lang: languageManager.selectedLanguage,
            avatar: avatar
        )
        if let currentUser = userVM.currentUser {
            print(currentUser)
        }
        
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.beigeBackground
                .ignoresSafeArea(.all)
            if horizontalSizeClass == .compact {
                VStack {
                    Text("Cài đặt")
                        .foregroundStyle(Color.signupTitle)
                        .modifier(LargeTitleTextModifier())
                    Spacer()
                        .frame(height: UIScreen.main.bounds.width * 0.1)
                    PersonInfo(selectedAvatar: $avatar)
                    Spacer()
                        .frame(height: UIScreen.main.bounds.width * 0.15)
                    VStack(alignment: .leading) {
                        LanguagePicker()
                        ThemePicker(scheme: scheme)
                    }
                    Spacer()
                        .frame(height: UIScreen.main.bounds.width * 0.2)
                    Button(action: {
                        saveSettings()
                    }) {
                        Text("Lưu")
                            .modifier(LargeButtonModifier(background: Color.primaryRed))
                        
                    }
                    .padding()
                }
            }
            else {
                VStack {
                    Text("Cài đặt")
                        .foregroundStyle(Color.darkRed)
                        .modifier(LargeTitleTextModifierIpad())
                    Spacer()
                        .frame(height: UIScreen.main.bounds.width * 0.1)
                    PersonInfo(selectedAvatar: $avatar)
                    Spacer()
                        .frame(height: UIScreen.main.bounds.width * 0.1)
                    VStack(alignment: .leading, spacing: 20) {
                        LanguagePicker()
                        ThemePicker(scheme: scheme)
                        
                    }
                    Spacer()
                    // Placeholder for error message
                    if userVM.success {
                        Text("Update Sucessfully!")
                            .foregroundStyle(Color.green)
                    }
                    // Placeholder for error message
                    if let message = userVM.errorMessage {
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
                        
                    }
                    .padding()
                }
                
            }
        }
        .preferredColorScheme(theme.colorScheme)
        .onAppear {
            if let userAvatar = userVM.currentUser?.avatar {
                avatar = userAvatar
            }
        }
        
            
    }
}

#Preview {
    let dummyUser = User(id: "1", username: "Test User", email: "test@example.com", avatar: "avatar1", darkMode: false, lang: "en")
    let userVM = UserViewModel()
    userVM.currentUser = dummyUser
    
    return MyProfileView()
        .environmentObject(UserViewModel())
        .environmentObject(LanguageManager())
    
}
