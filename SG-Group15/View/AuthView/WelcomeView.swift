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
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.beigeBackground
                        .ignoresSafeArea(.all)
                    VStack {
                        // Images with dynamic sizing
                        ZStack {
                            Image("welcomebg")
                                .resizable()
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.6)
                                .offset(x:geometry.size.width * 0.1)
                            Image("welcomefigure")
                                .resizable()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.4)
                        }
                        
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.02) {
                            Text("History App")
                                .font(.custom("OldStandardTT-Bold", size: geometry.size.width * 0.1))
                                .foregroundStyle(Color.darkGreen)
                            Text("Biến lịch sử thành cuộc phiêu lưu")
                                .font(.custom("Roboto-ThinItalic", size: geometry.size.width * 0.06))
                                .foregroundStyle(Color.darkGreen)
                            
                            Spacer().frame(height: geometry.size.height * 0.02)
                            
                            // Buttons
                            NavigationLink(destination: SignUpView(userViewModel: userViewModel)) {
                                Text("Đăng Ký")
                                    .modifier(SignUpButtonModifier(background: Color.primaryRed))
                            }
                            NavigationLink(destination: LoginView(userViewModel: userViewModel)) {
                                Text("Đăng nhập")
                                    .modifier(SignUpButtonModifier(background: Color.darkGreen))
                            }
                            
                            Spacer().frame(height: geometry.size.height * 0.02)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
