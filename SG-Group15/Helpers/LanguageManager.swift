//
//  LanguageManager.swift
//  SG-Group15
//
//  Created by Xian on 21/9/24.
//

import Foundation
import SwiftUI

// Manage changing the app language
class LanguageManager: ObservableObject {
    @Published var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"

    // Update the language
    func update(to newLang: String) {
        selectedLanguage = newLang
        UserDefaults.standard.set(newLang, forKey: "selectedLanguage")
        // Notify the listeners that the language has changed
        NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
    }
}
