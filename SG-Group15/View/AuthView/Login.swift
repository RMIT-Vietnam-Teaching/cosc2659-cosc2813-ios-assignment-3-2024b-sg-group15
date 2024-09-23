//
//  Login.swift
//  SG-Group15
//
//  Created by Nana on 21/9/24.
//

import SwiftUI

struct Login: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    // Manage user
    @EnvironmentObject var userViewModel:  UserViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.beigeBackground
                .ignoresSafeArea(.all)
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: horizontalSizeClass == .compact ? 15 : 30, height: horizontalSizeClass == .compact ? 15 : 30)
                        .modifier(BodyTextModifier(color: Color.darkGreen))
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 40)
            
            VStack {
                
                Spacer()
                // Title with headline
                VStack(spacing: horizontalSizeClass == .compact ? 10 : 30) {
                    Text("Đăng Nhập")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeTitleTextModifier()) : AnyViewModifier(LargeTitleTextModifierIpad()))
                        .foregroundStyle(Color.signupTitle)
                    
                    Text("Chào mừng bạn quay lại! Chúng tôi rất nhớ bạn")
                        
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
                        TextField("Nhập email", text: $email)
                            .foregroundColor(.darkRed)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                        // Disable auto capitalization
                            .textInputAutocapitalization(.never)
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
                        // Disable auto capitalization
                            .textInputAutocapitalization(.never)
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
                        
                        Text("Hoặc tiếp tục với")
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
                
                // Sign im button
                Button(action: {
//                    userViewModel.isLogin = true
                    self.userViewModel.login(email: email, password: password)
                    print(userViewModel.success)
//                    if userViewModel.success {
                        dismiss()
                        userViewModel.isLogin = true
//                    }
                })
                {
                    Text("Đăng nhập")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                        .foregroundColor(.white)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .darkRed)) : AnyViewModifier(LargeButtonModifierIpad(background: .darkRed)))
                    
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default navigation bar back button.
    }
}

#Preview {
    Login()
        .environmentObject(UserViewModel())

}
