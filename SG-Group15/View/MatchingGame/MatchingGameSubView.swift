//
//  MatchingGameSubView.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/21/24.
//

import SwiftUI

struct EventButton: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    let event: MatchingEvent
    let isSelected: Bool
    let action: () -> Void
    let size: CGSize
    
    var body: some View {
        Button(action: action) {
            Text(event.text)
                .frame(width: horizontalSizeClass == .compact ? 150 : 250, height: horizontalSizeClass == .compact ? 80 : 130)
                .background(backgroundForState())
                .foregroundColor(foregroundForState())
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(strokeForState(), lineWidth: horizontalSizeClass == .compact ? 2 : 3)
                )
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))                .minimumScaleFactor(0.5)
                .lineLimit(3)
        }
        .disabled(event.isMatched)
    }
    
    private func backgroundForState() -> Color {
        if event.isMatched {
            return .correctBackground
        } else if event.isIncorrectMatch {
            return .lightRed
        } else if isSelected {
            return .butteryWhite
        } else {
            return .clear
        }
    }
    
    private func strokeForState() -> Color {
        if event.isMatched {
            return .correctText
        } else if event.isIncorrectMatch {
            return .darkRed
        } else if isSelected {
            return .black
        } else {
            return .black
        }
    }
    
    private func foregroundForState() -> Color {
        if event.isMatched {
            return .correctText
        } else if event.isIncorrectMatch {
            return .darkRed
        }
        else {
            return .black
        }
    }
}
