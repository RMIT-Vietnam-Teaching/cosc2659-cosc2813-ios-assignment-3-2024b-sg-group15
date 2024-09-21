//
//  PageModel.swift
//  SG-Group15
//
//  Created by Nana on 14/9/24.
//

import Foundation

// Page model with an ID, content, and a property to determine if it can flip
class Page: ObservableObject, Identifiable {
    let id: UUID = UUID()
    var content: String
    @Published var canFlip: Bool
    
    init(content: String, canFlip: Bool) {
        self.content = content
        self.canFlip = canFlip
    }
}

// Chapter model containing an array of pages
struct Chapter: Identifiable {
    let id: UUID = UUID()
    var pages: [Page]
}

struct CoverPage: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
}
