//
//  Note.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import Foundation
import PencilKit

struct Note: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var textContent: String
    var drawingData: Data?
    var lastModified: Date
    
    init(title: String, textContent: String = "", drawing: PKDrawing? = nil, lastModified: Date = Date()) {
        self.title = title
        self.textContent = textContent
        self.lastModified = lastModified
        if let drawing = drawing {
            self.drawingData = drawing.dataRepresentation()
        }
    }
    
    // Convert drawingData back to PKDrawing
    func getDrawing() -> PKDrawing? {
        if let drawingData = drawingData {
            return try? PKDrawing(data: drawingData)
        }
        return nil
    }
}
