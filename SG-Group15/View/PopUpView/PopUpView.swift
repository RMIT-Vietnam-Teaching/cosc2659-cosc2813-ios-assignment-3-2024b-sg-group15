//
//  PopUpView.swift
//  SG-Group15
//
//  Created by Nana on 18/9/24.
//

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
