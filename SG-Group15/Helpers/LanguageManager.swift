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
