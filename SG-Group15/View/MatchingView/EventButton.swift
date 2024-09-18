//
//  EventButton.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation
import SwiftUI

struct EventButton: View {
    let event: MatchingEvent
    let isSelected: Bool
    let action: () -> Void
    let size: CGSize
    
    var body: some View {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let scaleBoxValue = isIpad ? 1 : 1.6
        Button(action: action) {
            Text(event.text)
                .padding(size.width * 0.05)
                .frame(width: size.width, height: size.height * scaleBoxValue)
                .background(backgroundForState())
                .foregroundColor(foregroundForState())
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.darkRed, lineWidth: 2)
                )
                .modifier(BodyTextModifier())
                .minimumScaleFactor(0.5)
                .lineLimit(3)
        }
        .disabled(event.isMatched)
    }
    
    private func backgroundForState() -> Color {
        if event.isMatched {
            return .green
        } else if event.isIncorrectMatch {
            return .red
        } else if isSelected {
            return .darkRed.opacity(0.3)
        } else {
            return .white
        }
    }
    
    private func foregroundForState() -> Color {
        if event.isMatched || event.isIncorrectMatch {
            return .white
        } else {
            return .black
        }
    }
}
