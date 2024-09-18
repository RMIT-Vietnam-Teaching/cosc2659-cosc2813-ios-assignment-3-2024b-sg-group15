//
//  DrawingView.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @Binding var canvasView: PKCanvasView
    @State private var toolPicker = PKToolPicker()
    @Binding var note: Note

    var body: some View {
        // Drawing Canvas Layer
        PencilCanvasView(canvasView: $canvasView, toolPicker: toolPicker, note: $note)
            .background(Color.clear) // Make the canvas background clear to see the underlying ZStack background

//            .edgesIgnoringSafeArea(.all)
//            .zIndex(0) // Draw canvas below the text editor
    }

}

#Preview {
    DrawingView(canvasView: .constant(PKCanvasView()), note: .constant(Note(title: "title")))
}
