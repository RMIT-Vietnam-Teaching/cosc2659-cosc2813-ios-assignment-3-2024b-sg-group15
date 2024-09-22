//
//  TabViewNote.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import SwiftUI
import PencilKit

struct TabViewNote: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userViewModel: UserViewModel

    @EnvironmentObject var noteViewModel: NoteViewModel

    @State var currentTab: Int = 0 // State variable to track the current tab
    @State private var canvasView = PKCanvasView()
    
    @State private var toolPicker = PKToolPicker()
    var noteID: String
    
    @State private var note: Note = Note(id: "", title: "", textContent: "", color: "")
    
    var newNote: Bool
    
    @State private var showInput: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            if !newNote && noteViewModel.isLoadNote {
                ProgressView("Đang tải...")
                    .font(.largeTitle)
                    .padding()
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: horizontalSizeClass == .compact ? 15 : 30, height: horizontalSizeClass == .compact ? 15 : 30)
                                .modifier(BodyTextModifier(color: Color.darkGreen))
                        }
                        
                        Spacer()
                        
                        Text("Tựa đề")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    
                    TabBarView(currentTab: self.$currentTab)
                    
                    ZStack {
                        if currentTab == 0 {
                            TypingView(note: $note)
                        } else if currentTab == 1 {
                            DrawingView(canvasView: $canvasView, toolPicker: $toolPicker, note: $note)
                        }
                    }
                    .animation(.easeInOut, value: currentTab)
                }
    
                
                .onChange(of: currentTab, initial: true) { _, newTab in
                    if newTab == 0 {
                        // Hide the tool picker when switching to the typing tab
                        toolPicker.setVisible(false, forFirstResponder: canvasView)
                    } else if newTab == 1 {
                        // Show the tool picker when switching to the drawing tab
                        toolPicker.setVisible(true, forFirstResponder: canvasView)
                        toolPicker.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                    }
                }
            }
            
            if showInput {
                InputBoxView(note: $note, selectedColor: $note.color, showInput: $showInput)
//                    .background(.pink)
            }
        }
        .onAppear {
            if newNote {
                print("new")
                withAnimation {
                    showInput = true
                }
            } else {
                noteViewModel.fetchNote(id: noteID) { fetchedNote in
                    if let noteData = fetchedNote {
                        print("Data loaded")
                        self.note = noteData  // Update the `note` only after the data is fetched
                    } else {
                        print("Failed to load note data.")
                    }
                }
            }
            
        }
        .onChange(of: note.textContent, initial: false) { oldValue, newValue in
            // When text content changes, update the note
            DispatchQueue.main.async {
                noteViewModel.updateNote(note)
            }
        }
        .onChange(of: note.drawingData, initial: false) { oldValue, newValue in
            // When text content changes, update the note
            DispatchQueue.main.async {
                noteViewModel.updateNote(note)
            }
        }
        
        .onChange(of: note.title, initial: false) { oldValue, newValue in
            if newNote {
                // When title changes and is not empty, save the note
                DispatchQueue.main.async {
                    noteViewModel.saveNote(note, userID: userViewModel.currentUser?.id)
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default navigation bar back button.

    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace // Namespace for matched geometry effect
    
    var tabBarOptions: [String] = ["Văn bản", "Vẽ"]
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0, content: { index, name in
                TabBarItems(currentTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index)
            })
        }
        .frame(maxHeight: 80)
        .padding(.horizontal, 15)
    }
}

struct TabBarItems: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @Binding var currentTab: Int
    let namespace: Namespace.ID // Namespace for matched geometry effect
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button(action: {
            self.currentTab = tab
        }, label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))

                    .foregroundColor(currentTab == tab ? Color(.pink) : Color(.black))

                if currentTab == tab { // If this is the current tab
                    Color(currentTab == tab ? Color(.pink) : Color("black-custom"))
                        .frame(height: 1)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear
                        .frame(height: 1)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            .animation(.spring(), value: self.currentTab) // Apply spring animation to the current tab change
        })
    }
}

#Preview {
    TabViewNote(noteID: "", newNote: true)
        .environmentObject(NoteViewModel())
        .environmentObject(UserViewModel())

}
