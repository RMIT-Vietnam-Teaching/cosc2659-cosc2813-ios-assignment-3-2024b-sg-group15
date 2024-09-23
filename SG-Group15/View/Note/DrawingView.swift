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
import PencilKit

struct DrawingView: View {
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    @Binding var note: Note

    var body: some View {
        // Drawing Canvas Layer
        PencilCanvasView(canvasView: $canvasView, toolPicker: toolPicker, note: $note)
            .background(Color.clear) // Make the canvas background clear to see the underlying ZStack background
    }

}

