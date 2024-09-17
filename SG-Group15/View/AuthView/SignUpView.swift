//
//  SignupView.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import SwiftUI
import FirebaseAuth


struct SignUpView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    
    // Manage user
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.beigeBackground
                    .ignoresSafeArea(.all)
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    // Title with headline
                    Text("Đăng Ký")
                        .font(.custom("Lato-Black", size: UIScreen.main.bounds.width * 0.1))
                        .foregroundStyle(Color.signupTitle)
                    Text("Cùng bắt đầu học nhé")
                        .modifier(HeadlineTextModifier())
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                    if userViewModel.success {
                        Text("Login Sucessfully!")
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
                    
                    // Receive user input
                    TextField("Nhập tên người dùng", text: $username)
                        .modifier(TextInputModifier())
                        .onChange(of: username) { old, new in
                            // Clear error message
                            userViewModel.errorMessage = nil
                        }
                    TextField("Nhập email", text: $email)
                        .modifier(TextInputModifier())
                        .onChange(of: email) { old, new in
                            // Clear error message
                            userViewModel.errorMessage = nil
                        }
                    // Hide password from user
                    SecureField("Nhập mật khẩu", text: $password)
                        .modifier(TextInputModifier())
                        .onChange(of: password) { old, new in
                            // Clear error message
                            userViewModel.errorMessage = nil
                        }
                    
                    // Sign up with Google option
                    VStack {
                        Text("Hoặc bắt đầu với")
                        Button(action: {
                            userViewModel.signinWithGoogle()
                        }) {
                            Image("search")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.03)
                                .padding()
                                .background(Color.lightRed.opacity(0.4))
                                .cornerRadius(10)
                        }
                    }
                    // Sign up button
                    Button(action: {
                        self.userViewModel.signup(email: email, password: password, username: username)
                    })
                    {
                        Text("Đăng ký")
                            .modifier(SignUpButtonModifier(background: Color.primaryRed))
                    }
                }
            }
            .toolbar {
                // Back to the welcome view
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .modifier(BodyTextModifier(color: Color.darkGreen))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpView()
}
