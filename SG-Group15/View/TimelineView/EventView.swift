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

struct EventView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel: TimelineGameViewModel
    let event: TimelineEvent
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            // Event background
            RoundedRectangle(cornerRadius: 15)
                .fill(backgroundColor)
                .frame(width: width, height: height)
            
            // Event border
            RoundedRectangle(cornerRadius: 15)
                .stroke(borderColor, lineWidth: horizontalSizeClass == .compact ? 3 : 4)
                .frame(width: width, height: height)
            
            // Event text
            Text(event.name)
                .minimumScaleFactor(0.5)
                .lineLimit(3)
                .padding(8)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                .foregroundColor(textColor)
                .multilineTextAlignment(.center)
                
        }
        .frame(width: width, height: height)
    }
    private var backgroundColor: Color {
            guard viewModel.isSubmitted else { return .clear }
            return viewModel.isEventCorrect(event) ? .correctBackground : .lightRed
        }
        
        private var borderColor: Color {
            guard viewModel.isSubmitted else { return .darkRed }
            return viewModel.isEventCorrect(event) ? .correctText : .darkRed
        }
        
        private var textColor: Color {
            guard viewModel.isSubmitted else { return .black }
            return viewModel.isEventCorrect(event) ? .correctText : .black
        }
}
