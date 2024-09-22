//
//  NoteListView.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct NoteListView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @StateObject var noteVM = NoteViewModel()
    @State private var note: Note = Note(id: "", title: "", textContent: "", color: "")
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // Define a two-column grid with flexible items
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.beigeBackground
                    .ignoresSafeArea()
                
                if noteVM.isLoading {
                   LoadingView()
                    
                } else {
                    VStack {
                        HStack {
                            Text("Your Notes")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                            
                            Spacer()
                            
                            NavigationLink {
                                TabViewNote(noteID: "", newNote: true)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: horizontalSizeClass == .compact ? 15 : 30, height: horizontalSizeClass == .compact ? 15 : 30)
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(.horizontal, horizontalSizeClass == .compact ? 20 : 40)
                        .padding(.vertical, 30)
                        
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: horizontalSizeClass == .compact ? 20 : 50) {
                                ForEach(noteVM.notes.indices, id: \.self) { index in
                                    NavigationLink {
                                        // Pass the binding to the note at the current index
                                        TabViewNote( noteID: noteVM.notes[index].id!, newNote: false)
                                    } label: {
                                        NoteCardView(note: noteVM.notes[index])
                                            .padding(.horizontal, 10)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, horizontalSizeClass == .compact ? 20 : 50)
                    }
                }
            }
            .onAppear {
                noteVM.loadNotes()
            }
        }
        .environmentObject(noteVM)
    }
}

#Preview {
    NoteListView()
}
