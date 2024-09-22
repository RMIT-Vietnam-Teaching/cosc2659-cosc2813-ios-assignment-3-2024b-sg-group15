//
//  User.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import FirebaseCore

// User model: Store user profile
struct User: Identifiable, Codable {
    // ID is also the document ID
    var id: String = UUID().uuidString
    var username: String
    var email: String
    var joinedAt: Date?
    
    // TODO: Add other fields in user profile later
    // Default initialization
    init(id: String, username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }
    
    // Initialize from the database's document
    init?(id: String, data: [String: Any]) {
        // Ensure the user fields exist
        guard let username = data["username"] as? String,
              let email = data["email"] as? String,
              let joinedAt = data["joinedAt"]
        else {
            print("Cannot parse user data")
            return nil
        }
        self.id = id
        self.username = username
        self.email = email
        // Retrieve the date value only
        self.joinedAt = (joinedAt as? Timestamp)?.dateValue()
        
    }
}
