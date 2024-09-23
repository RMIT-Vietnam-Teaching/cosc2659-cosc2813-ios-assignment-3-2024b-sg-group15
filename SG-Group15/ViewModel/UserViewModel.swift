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
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import Firebase
import FirebaseCore

class UserViewModel: ObservableObject {
    // Manage user changes
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var success: Bool = false
    @Published var isLogin: Bool = false
    
    // Instantiate database and authenticaton
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    // MARK: Sign up process
    // Save new user to database
    private func saveUser(uid: String, email: String, username: String) {
        let newUser = User(id: uid, username: username, email: email, avatar: "avatar1", darkMode: false, lang: "vi")
        
        // Save with the exact date the user is created
        db.collection("users").document(uid).setData([
            "username": username,
            "email": email,
            "joinedAt": FieldValue.serverTimestamp(),
            "avatar": newUser.avatar,
            "lang": newUser.lang,
            "darkMode": newUser.darkMode
        ])
        {  // Handle error
            error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            }
            else {
                print("User saved successfully!")
                self.currentUser = newUser
                self.isLogin = true
            }
            
        }
    }
    
    // Create a new user upon signing up
    private func createUser(email: String, password: String, username: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            // Handle error
            print("create")
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
                self.isLogin = true
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
                self.currentUser = User(id: uid, data: data)
                
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
                self.isLogin = true
                print("Login successfully!")
                // Fetch user data"
                self.fetchUser()
                if let user = self.currentUser {
                    print("Current user: \(user.username)")
                }
            }
        }
    }
    
    
    // Authenticate user using Google
    func signinWithGoogle() {
        // Configure the Google signin
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Find the root view controller to present the sign-in UI
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        // Start the Google Sign-In flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { userAuth, error in
            if let error = error {
                print("Error during Google Sign-In: \(error.localizedDescription)")
                return
            }
            
            // Extract credential from the Google user
            guard let user = userAuth?.user else { return }
            guard let idToken = userAuth?.user.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: user.accessToken.tokenString)
            // Sign in with Firebase using the Google credential
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase authentication failed: \(error.localizedDescription)")
                } else {
                    // Successfully signed in
                    print("User signed in with Google and Firebase")
                    if let authResult = authResult {
                        let uid = authResult.user.uid
                        let email = authResult.user.email ?? ""
                        // Take google's display name as username
                        let username = authResult.user.displayName ?? "Unknown"
                        
                        // Check if the email already exists
                        self.userExists(email: email) { emailExists in
                            if emailExists {
                                // Retrieve the user from the database
                                DispatchQueue.main.async {
                                    self.fetchUser()
                                }
                            }
                            else {
                                // New user creation
                                self.saveUser(uid: uid, email: email, username: username)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Logout
    func logout() {
        do {
            // Firebase sign-out
            try auth.signOut()
            
            // Google Sign-Out
                    GIDSignIn.sharedInstance.signOut()
            
            // Clear current user data
            self.currentUser = nil
            self.success = false
            self.isLogin = false
            
            print("User successfully logged out.")
        } catch let signOutError as NSError {
            // Handle any errors that might occur during the sign-out process
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    // MARK: Update user preferences
    func updatePreferences(darkMode: Bool, lang: String, avatar: String) {
        self.success = false
        guard let userId = Auth.auth().currentUser?.uid else { return }
        // Set new data for the current user
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData([
            "darkMode": darkMode,
            "lang": lang,
            "avatar": avatar
        ], merge: true) { error in
            if let error = error {
                self.errorMessage = "Error updating preferences"
                self.success = false
                print("Error updating preferences: \(error)")
            } else {
                self.success = true
                
            }
        }
    }

    
    
}
