//
//  UserViewModel.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    // Manage user changes
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var success: Bool = false
    
    // Instantiate database and authenticaton
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    // MARK: Sign up process
    // Save new user to database
    private func saveUser(uid: String, email: String, username: String) {
        let newUser = User(id: uid, username: username, email: email)
        
        // Save with the exact date the user is created
        db.collection("users").document(uid).setData([
            "username": username,
            "email": email,
            "joinedAt": FieldValue.serverTimestamp()
        ])
        {  // Handle error
            error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            }
            else {
                print("User saved successfully!")
                self.user = newUser
            }
            
        }
    }
    
    // Create a new user upon signing up
    private func createUser(email: String, password: String, username: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            // Handle error
            if let error = error {
                // Get error code for validation
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    // Invalid email
                    case .invalidEmail:
                        self.errorMessage = "Email không hợp lệ!"
                    default:
                        self.errorMessage = "Không thể đăng ký!"
                    }
                }
                print("Error signing up: \(error.localizedDescription)")
                self.success = false
            }
            else if let uid = result?.user.uid {
                self.success = true
                // Save to database
                self.saveUser(uid: uid, email: email, username: username)
            }
            
        }
    }
    
    
    // Check if the email already exists in the database
    private func userExists(email: String, completion: @escaping (Bool) -> Void) {
        // Query the database
        db.collection("users")
            .whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                // Handle error finding user
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(false)
                }
                else {
                    // Stop if found the user
                    let exist = !(snapshot?.isEmpty ?? true)
                    completion(exist)
                }
                
            }
    }
    
    // Sign up using email and password
    func signup(email: String, password: String, username: String) {
        // Check if the email already exists
        self.userExists(email: email) { emailExists in
            if emailExists {
                // Set error message
                DispatchQueue.main.async {
                    self.errorMessage = "Email đã tồn tại"
                    self.success = false
                }
            }
            else {
                // New user creation
                self.createUser(email: email, password: password, username: username)
            }
        }
    }
    
    // MARK: Login process
    // Fetch user data after login
    private func fetchUser() {
        guard let uid = auth.currentUser?.uid else {
            print("Failed to retrieve user id")
            return
        }
        db.collection("users").document(uid).getDocument { (document, error) in
            // Get user data from database
            if let document = document, let data = document.data() {
                self.user = User(id: uid, data: data)
                
            }
            else {
                print("Failed to fetch user: \(error?.localizedDescription ?? "")")
            }
        }
        
    }
    
    // Login using email and password
    func login(email: String, password: String) {
        // Try signing in
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                
                // Get error code for validation
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    // Incorrect password error
                    case .wrongPassword:
                        self.errorMessage = "Mật khẩu không chính xác!"
                    // Invalid email
                    case .invalidEmail:
                        self.errorMessage = "Email không hợp lệ!"
                    default:
                        self.errorMessage = "Email hoặc mật khẩu của bạn không chính xác!"
                    }
                }
                print("Failed to login: \(error.localizedDescription)")
                self.success = false
            }
            else {
                self.success = true
                print("Login successfully!")
                // Fetch user data"
                self.fetchUser()
                if let user = self.user {
                    print("Current user: \(user.username)")
                }
            }
        }
    }
    
    
}
