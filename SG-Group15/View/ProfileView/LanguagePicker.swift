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

struct LanguagePicker: View {
    // Handle change language
    @EnvironmentObject var languageManager: LanguageManager
    @State private var selected: String = (UserDefaults.standard.string(forKey: "selectedLanguge") ?? "vi")
    // Detect horizontal size class
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let languages = ["Anh", "Việt"]
    let langCodes = ["en", "vi"]
    @Namespace var animation
    var body: some View {
        if horizontalSizeClass == .compact {
            HStack(spacing: UIScreen.main.bounds.width * 0.1) {
                Text("Ngôn ngữ")
                    .foregroundStyle(Color.signupTitle)
                    .modifier(BodyTextModifier())
                HStack {
                    // Display the theme for user to choose
                    ForEach(Array(zip(languages, langCodes)), id: \.1) { lang, code in
                        Text(lang)
                            .modifier(BodyTextModifier())
                            .padding(10)
                            .background {
                                ZStack {
                                    // Highlight the selected language
                                    if languageManager.selectedLanguage == code {
                                        Capsule()
                                            .fill(Color.lightRed)
                                            .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                    }
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // Update the selected language when tapped
                                languageManager.update(to: code)
                            }
                    }
                }
            }
            // Change the language the the user chooses
            .onChange(of: languageManager.selectedLanguage) { oldVal, newVal in
                languageManager.update(to: newVal)
            }
        }
        else {
            HStack(spacing: UIScreen.main.bounds.width * 0.1) {
                Text("Ngôn ngữ")
                    .foregroundStyle(Color.signupTitle)
                    .modifier(BodyTextModifierIpad())
                HStack {
                    // Display the theme for user to choose
                    ForEach(Array(zip(languages, langCodes)), id: \.1) { lang, code in
                        Text(lang)
                            .modifier( BodyTextModifierIpad())
                            .padding(10)
                            .background {
                                ZStack {
                                    // Highlight the selected language
                                    if languageManager.selectedLanguage == code {
                                        Capsule()
                                            .fill(Color.lightRed)
                                            .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                    }
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // Update the selected language when tapped
                                languageManager.update(to: code)
                            }
                    }
                }
            }
            // Change the language the the user chooses
            .onChange(of: languageManager.selectedLanguage) { oldVal, newVal in
                languageManager.update(to: newVal)
            }
        }
    }
}

#Preview {
    LanguagePicker()
        .environmentObject(LanguageManager())
}
