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

import Foundation
import PencilKit

struct Note: Identifiable, Codable, Equatable {
    var id: String?
    var title: String
    var textContent: String
    var drawingData: Data?
    var lastModified: Date
    var color: String
    
    init(id: String?, title: String, textContent: String = "", drawing: PKDrawing? = nil, lastModified: Date = Date(), color: String) {
        self.id = id
        self.title = title
        self.textContent = textContent
        self.lastModified = lastModified
        if let drawing = drawing {
            self.drawingData = drawing.dataRepresentation()
        }
        self.color = color
    }
    
    // Init from database
    init?(documentID: String?, data: [String: Any]) {
        guard
            let title = data["title"] as? String,
            let lastModified = data["lastModified"] as? Date,
            let color = data["color"] as? String,
            let textContent = data["textContent"] as? String
        else { return nil }
        
        self.id = documentID
        self.title = title
        
        var drawing: PKDrawing? = nil
        if let drawingBase64 = data["drawingData"] as? String,
           let drawingData = Data(base64Encoded: drawingBase64) {
            drawing = try? PKDrawing(data: drawingData)
        }
        
        if let drawing = drawing {
            self.drawingData = drawing.dataRepresentation()
        }
        
        self.textContent = textContent
        
        self.lastModified = lastModified
        self.color = color
    }
    
    // Convert drawingData back to PKDrawing
    func getDrawing() -> PKDrawing? {
        if let drawingData = drawingData {
            return try? PKDrawing(data: drawingData)
        }
        return nil
    }
}
