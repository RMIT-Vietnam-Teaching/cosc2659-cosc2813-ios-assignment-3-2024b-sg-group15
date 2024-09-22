//
//  ThemePicker.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

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
