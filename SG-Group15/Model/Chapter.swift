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

// Chapter model containing an array of pages
struct Chapter: Identifiable {
    var id: String
    var title: String
    var description: String
    var odrer: Int
    var questions: [QuestionProtocol]
    
    init(id: String, title: String, description: String, questions: [QuestionProtocol], order: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.questions = questions
        self.odrer = order
    }
    
    // Initialize with data from database
    init?(documentID: String, data: [String: Any]) {
        guard let title = data["title"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let order = data["order"] as? Int else { return nil }
        self.id = documentID
        self.odrer = order
        self.title = title
        self.description = description
        self.questions = [] // Initially empty, will be populated by fetchQuestions
    }
}
