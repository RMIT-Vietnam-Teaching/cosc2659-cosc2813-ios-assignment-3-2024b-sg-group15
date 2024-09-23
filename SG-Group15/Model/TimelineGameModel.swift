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

// Structures supporting the elements in the Timeline game
struct TimelineEvent: Identifiable, Equatable {
    let id: Int
    let name: String
    var position: CGPoint
    var isPlaced: Bool = false
    var currentPeriod: Int?
    var originalPosition: CGPoint
}

struct TimePeriod: Identifiable {
    let id: Int
    let period: String
    var position: CGPoint
    let displayOrder: Int
}

struct MatchingEvent: Identifiable {
    let id: Int
    let text: String
    let correctMatchId: Int
    var isMatched = false
    var isIncorrectMatch = false
}

// Structure to fetch question from database 
struct TimelineQuestion: Identifiable, QuestionProtocol {
    var id: String
    var question: String
    var periods: [String]
    var events: [String]
    var questionType: QuestionType = .timeline
    
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
