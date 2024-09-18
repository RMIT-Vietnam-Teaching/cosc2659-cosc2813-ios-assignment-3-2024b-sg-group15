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
    var periods: [String]
    var events: [String]
    
    // Initialize from Firestore document ID and data
    init?(documentID: String, data: [String: Any]) {
        guard let question = data["question"] as? String,
              let periods = data["periods"] as? [String],
              let events = data["events"] as? [String] else {
            return nil
        }
        
        self.id = documentID
        self.question = question
        self.periods = periods
        self.events = events
    }
}
