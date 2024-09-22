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
    @State private var searchText: String = ""
    @State private var filter: String = ""
    @State private var isFilter: Bool = false
    @State private var noteList: [Note] = []
    
    var colorList = ["bookmarkColor1", "bookmarkColor2", "bookmarkColor3", "correctButton", "lightRed", "primaryRed"]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())] // Define a two-column grid with flexible items
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.beigeBackground
                    .ignoresSafeArea()
                
                if noteVM.isLoading {
                   LoadingView()
                    
                } else {
                    VStack(spacing: 10) {
                        HStack {
                            Text("Your Notes")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                            
                            Spacer()
                            
                            NavigationLink {
                                TabViewNote(noteID: "", newNote: true)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: horizontalSizeClass == .compact ? 20 : 30, height: horizontalSizeClass == .compact ? 20 : 30)
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(.horizontal, horizontalSizeClass == .compact ? 20 : 40)
                        .padding(.vertical, 30)
                        
                        ZStack(alignment: .top) {
                            
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: horizontalSizeClass == .compact ? 20 : 50) {
                                    ForEach(noteList.indices, id: \.self) { index in
                                        NavigationLink {
                                            // Pass the binding to the note at the current index
                                            TabViewNote( noteID: noteList[index].id!, newNote: false)
                                        } label: {
                                            NoteCardView(note: noteList[index])
                                                .padding(.horizontal, 10)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, horizontalSizeClass == .compact ? 20 : 50)
                            .padding(.top, 80)
                            
                            VStack(alignment: .leading ,spacing: 10) {
                                FilterView(isFilter: $isFilter, searchText: $searchText, filter: $filter, filterFunction: filterProducts)
                                
                                if isFilter {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 350, height: 60)
                                            .padding(.horizontal, 20)
                                            .foregroundColor(.white)
                                        
                                        HStack(spacing: 20) {
                                            ColorPicker(selectedColor: $filter, color: "none")
                                            
                                            ForEach(Array(zip(self.colorList.indices, self.colorList)), id: \.0, content: { index, color in
                                                ColorPicker(selectedColor: $filter, color: color)
                                            })
                                           
                                        }
                                    }
                                    .onChange(of: filter, initial: false) {
//                                        noteVM.loadNotes()
                                        filterProducts()
                                    }

                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                noteVM.loadNotes()
                noteList = noteVM.notes
            }
        }
        .environmentObject(noteVM)
    }
    
    // Function to capitalize words
    private func capitalizedWords(word: String) -> String {
            return word.lowercased().split(separator: " ").map { $0.capitalized }.joined(separator: " ")
        }
    
    // Function to filter products
    private func filterProducts() {
        noteList = noteVM.notes
        if filter != "none" && filter != "" {
            noteList = noteVM.notes.filter { note in
                return note.color.contains(filter)
            }
        }
        
        if searchText != "" { // Apply search filter if searchText is not empty
            let capitalSearchText = capitalizedWords(word: searchText)
            noteList = noteVM.notes.filter { note in
                return note.title.contains(capitalSearchText)
            }
        }
    }
    
}

#Preview {
    NoteListView()
}
