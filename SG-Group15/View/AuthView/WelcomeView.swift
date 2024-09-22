//
//  WelcomeView.swift
//  SG-Group15
//
//  Created by Xian on 15/9/24.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @EnvironmentObject var userViewModel:  UserViewModel
    
    var body: some View {
        NavigationStack {
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
                    VStack(alignment: .center, spacing: UIScreen.main.bounds.height * 0.02) {
                        Text("History App")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeTitleTextModifier()) : AnyViewModifier(LargeTitleTextModifierIpad()))
                            .foregroundStyle(Color.darkGreen)
                        
                        Text("Biến lịch sử thành cuộc phiêu lưu")
                            .scaledFont(name: "Roboto-ThinItalic", size: horizontalSizeClass == .compact ? 20 : 40, maxSize: horizontalSizeClass == .compact ? 30 : 50)
                            .foregroundStyle(Color.darkGreen)
                        Spacer()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.02, maxHeight: UIScreen.main.bounds.height * 0.04)
                        
                        // Login and Signup button
                        NavigationLink(destination: SignUp())
                        {
                            Text("Đăng ký")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                                .foregroundColor(.white)
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .primaryRed)) : AnyViewModifier(LargeButtonModifierIpad(background: .primaryRed)))
                        }
                        NavigationLink(destination: Login())
                        {
                            Text("Đăng nhập")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                                .foregroundColor(.white)
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .darkGreen)) : AnyViewModifier(LargeButtonModifierIpad(background: .darkGreen)))
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
        .environmentObject(UserViewModel())
}
