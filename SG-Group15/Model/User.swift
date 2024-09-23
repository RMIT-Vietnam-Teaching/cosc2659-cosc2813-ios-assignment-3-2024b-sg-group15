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
import FirebaseCore

// User model: Store user profile
struct User: Identifiable, Codable {
    // ID is also the document ID
    var id: String = UUID().uuidString
    var username: String
    var email: String
    var joinedAt: Date?
    // Control user's setting preferences
    var darkMode: Bool
    var lang: String
    var avatar: String
    
    
    // Default initialization
    init(id: String, username: String, email: String, avatar: String, darkMode: Bool, lang: String) {
        self.id = id
        self.username = username
        self.email = email
        // Default user preference
        self.avatar = avatar
        self.darkMode = darkMode
        self.lang = lang
        
    }
    
    // Initialize from the database's document
    init?(id: String, data: [String: Any]) {
        // Ensure the user fields exist
        guard let username = data["username"] as? String,
              let email = data["email"] as? String,
              let joinedAt = data["joinedAt"],
              let avatar = data["avatar"] as? String,
              let darkMode = data["darkMode"] as? Bool,
              let lang = data["lang"] as? String
        else {
            print("Cannot parse user data")
            return nil
        }
        self.id = id
        self.username = username
        self.email = email
        // Retrieve the date value only
        self.joinedAt = (joinedAt as? Timestamp)?.dateValue()
        self.avatar = avatar
        self.darkMode = darkMode
        self.lang = lang
        
    }
}
