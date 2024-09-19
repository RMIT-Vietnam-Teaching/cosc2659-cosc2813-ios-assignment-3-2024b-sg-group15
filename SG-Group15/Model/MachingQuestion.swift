//
//  MachingQuestion.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

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
