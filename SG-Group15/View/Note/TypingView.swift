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

struct TypingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    private let placeholder: String = "Nhập vào đây..."
    @Binding var note: Note

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Placeholder Text
            if note.textContent == "" {
                Text(placeholder)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                    .padding(.horizontal, horizontalSizeClass == .compact ? 8 : 20)
                    .padding(.vertical, 12)
            }
            
            // Transparent TextEditor
            TextEditor(text: $note.textContent)
                .padding(4)
                .background(Color.clear) // Set the background to transparent
                .scrollContentBackground(.hidden)
        }
    }
}

//#Preview {
//    TypingView(note: .constant(Note(title: "title")))
//}
