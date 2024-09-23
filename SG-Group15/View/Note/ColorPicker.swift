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
