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

// Model used for Matching question and Timeline question
struct MatchingQuestion: Identifiable, QuestionProtocol {
    var id: String
    var question: String
    var left: [String]
    var right: [String]
    var questionType: QuestionType = .matching
    
    // Initialize from Firestore document ID and data
    init?(documentID: String, data: [String: Any]) {
        guard let question = data["question"] as? String,
              let left = data["left"] as? [String],
              let right = data["right"] as? [String] else {
            return nil
        }
        
        self.id = documentID
        self.left = left
        self.right = right
        self.question = question
    }
}
