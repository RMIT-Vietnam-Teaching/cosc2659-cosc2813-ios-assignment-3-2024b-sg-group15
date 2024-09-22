//
//  PencilCanvasView.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import SwiftUI
import PencilKit

struct PencilCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let toolPicker: PKToolPicker
    @Binding var note: Note

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        // Set the delegate to the context coordinator to monitor drawing changes
        canvasView.delegate = context.coordinator
        
        canvasView.backgroundColor = .clear
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // Update the drawing only if the loaded drawing is different
        if let drawingData = note.drawingData,
           let loadedDrawing = try? PKDrawing(data: drawingData),
           loadedDrawing != uiView.drawing {
            uiView.drawing = loadedDrawing
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator to handle canvas changes
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: PencilCanvasView

        init(_ parent: PencilCanvasView) {
            self.parent = parent
        }

        // This method is called whenever the drawing changes
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.saveNoteWithDrawing() // Save the drawing whenever it changes
        }
    }
    
    // Save the note with the current drawing
    func saveNoteWithDrawing() {
        let drawing = canvasView.drawing
        note.drawingData = drawing.dataRepresentation()
        note.lastModified = Date()
//        NoteManager.save(note: note)
    }
}
