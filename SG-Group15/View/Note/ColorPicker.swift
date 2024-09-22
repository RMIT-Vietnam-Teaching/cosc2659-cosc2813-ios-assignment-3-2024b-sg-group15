//
//  ColorPicker.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct ColorPicker: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @Binding var selectedColor: String
    
    var color: String
    
    var body: some View {
        if color == "none" {
            Image(systemName: "circle.slash")
                .resizable()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .overlay {
                    if selectedColor == color {
                        Circle()
                            .stroke(lineWidth: 1)
                            .frame(width: horizontalSizeClass == .compact ? 40 : 60, height: horizontalSizeClass == .compact ? 40 : 60)
                    }
                }
                .onTapGesture {
                    selectedColor = color
                }
        } else {
            Circle()
                .frame(width: horizontalSizeClass == .compact ? 30 : 50, height: horizontalSizeClass == .compact ? 30 : 50)
                .foregroundColor(Color(color))
                .overlay {
                    if selectedColor == color {
                        Circle()
                            .stroke(lineWidth: 1)
                            .frame(width: horizontalSizeClass == .compact ? 40 : 60, height: horizontalSizeClass == .compact ? 40 : 60)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        selectedColor = color
                    }
                }
        }
        
    }
}

#Preview {
    ColorPicker(selectedColor: .constant("none"), color: "none")
}
