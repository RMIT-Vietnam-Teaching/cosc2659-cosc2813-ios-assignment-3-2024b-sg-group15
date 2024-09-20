//
//  TimelineGameModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/14/24.
//

import SwiftUI

//
//  TimelineGameModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/14/24.
//

import SwiftUI

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




