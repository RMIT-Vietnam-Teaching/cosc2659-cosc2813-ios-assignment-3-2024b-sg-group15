//
//  LoginView.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment (\.dismiss) private var dismiss
    // Manage user
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.beigeBackground
                    .ignoresSafeArea(.all)
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    // Title with headline
                    Text("Đăng Nhập")
                        .font(.custom("Lato-Black", size: UIScreen.main.bounds.width * 0.1))
                        .foregroundStyle(Color.signupTitle)
                    Text("Chào mừng bạn quay lại!")
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
                    
                    // Sign in with Google option
                    VStack {
                        Text("Hoặc tiếp tục với")
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
                        self.userViewModel.login(email: email, password: password)
                    })
                    {
                        Text("Đăng nhập")
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
    LoginView()
}
