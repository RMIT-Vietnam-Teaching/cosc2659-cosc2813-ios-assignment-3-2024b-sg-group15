//
//  WelcomeView.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @StateObject private var userViewModel = UserViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.beigeBackground
                    .ignoresSafeArea(.all)
                VStack {
                    ZStack {
                        // Illustration
                        Image("welcomebg")
                            .resizable()
                            .frame(minWidth: UIScreen.main.bounds.width * 0.7, maxWidth: UIScreen.main.bounds.width * 0.8, minHeight: UIScreen.main.bounds.height * 0.5, maxHeight: UIScreen.main.bounds.height * 0.6)
                            .position(x: UIScreen.main.bounds.width / 1.6, y: UIScreen.main.bounds.height / 4)
                        Image("welcomefigure")
                            .resizable()
                            .frame(minWidth: UIScreen.main.bounds.width * 0.8, maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: UIScreen.main.bounds.height * 0.3, maxHeight: UIScreen.main.bounds.height * 0.4)
                            .position(x: UIScreen.main.bounds.width / 1.8, y: UIScreen.main.bounds.height / 4)
                    }
                    
                    // Title and navigation
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.02) {
                        Text("History App")
                            .font(.custom("OldStandardTT-Bold", size: UIScreen.main.bounds.width * 0.1))
                            .foregroundStyle(Color.darkGreen)
                        Text("Biến lịch sử thành cuộc phiêu lưu")
                            .font(.custom("Roboto-ThinItalic", size:
                                            UIScreen.main.bounds.width * 0.06))
                            .foregroundStyle(Color.darkGreen)
                        Spacer()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.02, maxHeight: UIScreen.main.bounds.height * 0.04)
                        
                        // Login and Signup button
                        NavigationLink(destination: SignUpView(userViewModel: userViewModel))
                        {
                            Text("Đăng Ký")
                                .modifier(SignUpButtonModifier(background: Color.primaryRed))
                        }
                        NavigationLink(destination: LoginView(userViewModel: userViewModel))
                        {
                            Text("Đăng nhập")
                                .modifier(SignUpButtonModifier(background: Color.darkGreen))
                        }
                        Spacer()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.02, maxHeight: UIScreen.main.bounds.height * 0.04)
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
