//
//  LanguagePicker.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

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
                    ForEach(languages, id: \.self) {
                        lang in
                        Text(lang)
                            .modifier(BodyTextModifier())
                            .padding(10)
                            .background {
                                ZStack {
                                    // Highlight the chosen theme
                                    if selected == lang {
                                        Capsule()
                                            .fill(Color.lightRed)
                                            .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                    }
                                }
                                .animation(.snappy, value: lang)
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                selected = lang
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
                    .modifier(BodyTextModifierIpad())
                HStack {
                    // Display the theme for user to choose
                    ForEach(languages, id: \.self) {
                        lang in
                        Text(lang)
                            .modifier(BodyTextModifierIpad())
                            .padding(10)
                            .background {
                                ZStack {
                                    // Highlight the chosen theme
                                    if selected == lang {
                                        Capsule()
                                            .fill(Color.lightRed)
                                            .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                    }
                                }
                                .animation(.snappy, value: lang)
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                selected = lang
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
