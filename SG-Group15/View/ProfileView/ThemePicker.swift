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

// Control theme by case
enum Theme: String, CaseIterable {
    case system =  "Hệ thống"
    case light = "Sáng"
    case dark = "Tối"
    
    // Adjust color scheme
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

func getEffectiveTheme(theme: Theme, systemColorScheme: ColorScheme) -> Theme {
    switch theme {
    case .light:
        return .light
    case .dark:
        return .dark
    case .system:
        return systemColorScheme == .light ? .light : .dark
    }
}

struct ThemePicker: View {
    var scheme: ColorScheme
    @AppStorage("theme") private var theme: Theme = .light
    // Detect horizontal size class
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Namespace var animation
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width * 0.05) {
            Text("Chủ đề")
                .foregroundStyle(Color.signupTitle)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
            HStack {
                // Display the theme for user to choose
                ForEach(Theme.allCases, id: \.rawValue) {
                    th in
                    Text(th.rawValue)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        .padding(10)
                        .background {
                            ZStack {
                                // Highlight the chosen theme
                                if theme == th {
                                    Capsule()
                                        .fill(.lightRed)
                                        .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                }
                            }
                            .animation(.snappy, value: theme)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            theme = th
                        }
                }
            }
            .padding()
            .environment(\.colorScheme, scheme)
        }
    }
}

#Preview {
    ThemePicker(scheme: .light)
}
