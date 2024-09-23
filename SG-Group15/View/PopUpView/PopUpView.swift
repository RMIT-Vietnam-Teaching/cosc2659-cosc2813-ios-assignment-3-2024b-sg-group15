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

struct PopUpView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 20) {
                Text("Bingo")
                    .foregroundColor(.correctText)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
            }
            
            
            Button(action: {}, label: {
                Text("Tiếp tục")
                    .foregroundColor(.white)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(MediumButtonModifier(background: .correctButton)) : AnyViewModifier(MediumButtonModifierIpad(background: .correctButton)))
               
            })
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                isVisible = true
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.correctBackground)
                .frame(width: horizontalSizeClass == .compact ? 300 : 350, height: horizontalSizeClass == .compact ? 200 : 250)
        }
        .frame(width: horizontalSizeClass == .compact ? 300 : 350, height: horizontalSizeClass == .compact ? 200 : 250)
        .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
        .opacity(isVisible ? 1 : 0)
    }
    
}

#Preview {
    PopUpView()
}
