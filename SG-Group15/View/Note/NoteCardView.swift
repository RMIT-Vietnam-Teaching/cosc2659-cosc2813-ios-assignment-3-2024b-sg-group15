//
//  NoteCardView.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct NoteCardView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var noteViewModel: NoteViewModel
    
    var note: Note
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: horizontalSizeClass == .compact ?  160 : 250, height: horizontalSizeClass == .compact ?  160 : 250)
                .foregroundColor(Color(note.color))
            
            Button(action: {
                noteViewModel.deleteNote(id: note.id!)
            }, label: {
                Image(systemName: "xmark.bin.circle.fill")
                    .resizable()
                    .frame(width: horizontalSizeClass == .compact ? 20 : 30, height: horizontalSizeClass == .compact ? 20 : 30)
                    .foregroundColor(.black)
            })
            
            .offset(x: horizontalSizeClass == .compact ? 60 : 90, y: horizontalSizeClass == .compact ? 60 : 90)
            
            VStack(spacing: 20) {
                Text(note.title)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(HeadlineTextModifier()) : AnyViewModifier(HeadlineTextModifierIpad()))
                    .foregroundColor(.black)
            }
            .frame(width: horizontalSizeClass == .compact ?  140 : 240, height: horizontalSizeClass == .compact ?  140 : 240)
        }
    }
}

#Preview {
    NoteCardView(note: Note(id: "", title: "Title", textContent: "Lorem ispum balbalbawkrmcnklsmcnklbalbala", color: "lightRed"))
        .environmentObject(NoteViewModel())

}
