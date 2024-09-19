//
//  Chapter.swift
//  SG-Group15
//
//  Created by Do Le Long An on 19/9/24.
//

import Foundation

// Chapter model containing an array of pages
struct Chapter: Identifiable {
    var id: String
    var title: String
    var description: String
    var questions: [QuestionProtocol]
    
    // Initialize with data from database
    init?(documentID: String, data: [String: Any]) {
        guard let title = data["title"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        self.id = documentID
        self.title = title
        self.description = description
        self.questions = [] // Initially empty, will be populated by fetchQuestions
    }
}
