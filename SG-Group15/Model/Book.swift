//
//  Book.swift
//  SG-Group15
//
//  Created by Xian on 19/9/24.
//

import Foundation
struct Book: Identifiable {
    var id: String
    var title: String
    var chapters: [Chapter]
    
    // Initialize with data from database
    init?(documentID: String, data: [String: Any]) {
        guard let title = data["title"] as? String else { return nil }
        self.id = documentID
        self.title = title
        self.chapters = []
    }
}
