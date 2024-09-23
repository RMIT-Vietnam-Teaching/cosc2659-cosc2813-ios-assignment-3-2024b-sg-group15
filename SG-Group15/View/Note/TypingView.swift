//
//  TypingView.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

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
