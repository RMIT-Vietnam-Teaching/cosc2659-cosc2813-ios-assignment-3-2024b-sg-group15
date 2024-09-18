//
//  TypingView.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import SwiftUI

struct TypingView: View {
    private let placeholder: String = "Type something here..."
    @Binding var note: Note

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Placeholder Text
            if note.textContent == "" {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
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

#Preview {
    TypingView(note: .constant(Note(title: "title")))
}
