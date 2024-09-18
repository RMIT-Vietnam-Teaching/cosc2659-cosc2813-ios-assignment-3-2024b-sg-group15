//
//  TabViewNote.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import SwiftUI
import PencilKit

struct TabViewNote: View {
    @State private var note = Note(title: "Sample Note")
    @State var currentTab: Int = 0 // State variable to track the current tab
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                TabBarView(currentTab: self.$currentTab)

                ZStack {
                    if currentTab == 0 {
                        TypingView(note: $note)
                    } else if currentTab == 1 {
                        DrawingView(canvasView: $canvasView, note: $note)
                    }
                }
                .animation(.easeInOut, value: currentTab)
            }
        }
        .onAppear {
            loadNote()
        }
        .onChange(of: note.textContent, initial: false) {
            saveNoteWithDrawing()
        }
        .onChange(of: note.drawingData, initial: false) {
            saveNoteWithDrawing()
        }
    }
    
    // Save the note with the current drawing
    func saveNoteWithDrawing() {
        // Extract the drawing from the canvas and save it to the note
        let drawing = canvasView.drawing
        note.drawingData = drawing.dataRepresentation()
        note.lastModified = Date()
        
        // Save the note to UserDefaults
        NoteManager.save(note: note)
    }
    
    func loadNote() {
        if let loadedNote = NoteManager.load() {
            note = loadedNote
            
            // If there is drawing data, load it into the canvas
            if let drawing = note.getDrawing() {
                canvasView.drawing = drawing
            }
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace // Namespace for matched geometry effect
    
    var tabBarOptions: [String] = ["Text", "Drawing"]
    
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
                    .scaledFont(name: "Lato-Light", size: 20, maxSize: 24)

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
    TabViewNote()
}
