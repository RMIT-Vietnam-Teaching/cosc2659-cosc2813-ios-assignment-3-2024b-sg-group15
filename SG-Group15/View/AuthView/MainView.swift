//
//  MainView.swift
//  SG-Group15
//
//  Created by Nana on 21/9/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        ZStack {
            if userViewModel.isLogin {
                BookMenuView()
            } else {
                WelcomeView()
            }
        }
        .environmentObject(userViewModel)
    }
}

#Preview {
    MainView()
}
