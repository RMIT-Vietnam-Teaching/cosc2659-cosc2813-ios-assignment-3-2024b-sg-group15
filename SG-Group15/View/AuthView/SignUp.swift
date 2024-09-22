//
//  SignUp.swift
//  SG-Group15
//
//  Created by Nana on 21/9/24.
//

import SwiftUI

struct SignUp: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.dismiss) private var dismiss
    // Manage user
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Color.beigeBackground
                .ignoresSafeArea(.all)
            VStack {
                
                Spacer()
                // Title with headline
                VStack(spacing: horizontalSizeClass == .compact ? 10 : 30) {
                    Text("Đăng Ký")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeTitleTextModifier()) : AnyViewModifier(LargeTitleTextModifierIpad()))
                        .foregroundStyle(Color.signupTitle)
                    
                    Text("Xin chào bạn! Mình cùng nhau khám phá nhé!")
                        
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                }

                Spacer()
                
                VStack(spacing: horizontalSizeClass == .compact ? 20 : 40) {
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
                    
                    
                    VStack(spacing: horizontalSizeClass == .compact ? 30 : 50) {
                        
                        // Receive user input
                        TextField("Nhập tên người dùng", text: $username)
                            .foregroundColor(.darkRed)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                        
                            .onChange(of: username) { old, new in
                                // Clear error message
                                userViewModel.errorMessage = nil
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2) // Thickness of the underline
                                    .foregroundColor(.darkRed), // Color of the underline
                                alignment: .bottom // Align at the bottom of the TextField
                            )
                            .padding(.horizontal, horizontalSizeClass == .compact ? 30 : 50)
                        
                        // Receive user input
                        TextField("Nhập email", text: $email)
                            .foregroundColor(.darkRed)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                        
                            .onChange(of: email) { old, new in
                                // Clear error message
                                userViewModel.errorMessage = nil
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2) // Thickness of the underline
                                    .foregroundColor(.darkRed), // Color of the underline
                                alignment: .bottom // Align at the bottom of the TextField
                            )
                            .padding(.horizontal, horizontalSizeClass == .compact ? 30 : 50)

                        
                        // Hide password from user
                        SecureField("Nhập mật khẩu", text: $password)
                            .foregroundColor(.darkRed)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                            .onChange(of: password) { old, new in
                                // Clear error message
                                userViewModel.errorMessage = nil
                            }
                            .padding(.bottom, 8)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2) // Thickness of the underline
                                    .foregroundColor(.darkRed), // Color of the underline
                                alignment: .bottom // Align at the bottom of the TextField
                            )
                            .padding(.horizontal, horizontalSizeClass == .compact ? 30 : 50)
                        
                        Text("Hoặc bắt đầu với")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            userViewModel.signinWithGoogle()
                        }) {
                            HStack(spacing: horizontalSizeClass == .compact ? 10 : 20) {
                                Text("Đăng nhập với Google")
                                    .foregroundColor(.darkRed)
                                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))

                                Image("search")
                                    .resizable()
                                    .frame(width: horizontalSizeClass == .compact ? 20 : 30, height: horizontalSizeClass == .compact ? 20 : 30)
                                
                            }
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(RegularButtonModifier(background: .lightRed.opacity(0.6))) : AnyViewModifier(RegularButtonModifierIpad(background: .lightRed.opacity(0.6))))
                        }
                        
                    }

                }
                
                Spacer()
                
                // Sign up button
                Button(action: {
                    self.userViewModel.signup(email: email, password: password, username: username)
                })
                {
                    Text("Đăng ký")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                        .foregroundColor(.white)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .darkRed)) : AnyViewModifier(LargeButtonModifierIpad(background: .darkRed)))
                    
                }
                
                Spacer()
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
}

#Preview {
    SignUp(userViewModel: UserViewModel())
}
