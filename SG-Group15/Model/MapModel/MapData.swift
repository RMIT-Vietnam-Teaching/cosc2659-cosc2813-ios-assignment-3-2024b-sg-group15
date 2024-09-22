//
//  MapData.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/22/24.
//

import SwiftUI


struct MapData {
    let mapImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
    let correctAnswer: String
    let config: MapComponentConfig
}

struct MapComponentConfig {
    let animationGifName: String
    let animationDuration: Double
    let animationSize: (compact: CGSize, regular: CGSize)
    let animationPosition: (compact: CGPoint, regular: CGPoint)
    let animationOffset: CGSize
}

import Foundation

// Model used for Map question
struct MapQuestion: Identifiable, QuestionProtocol {
    var id: String
    var question: String
    var mapChoices: [String]
    var correct: String
    var questionType: QuestionType = .map
    
    // Initialize from Firestore document ID and data
    init?(documentID: String, data: [String: Any]) {
        guard let question = data["mapQuestion"] as? String,
              let mapChoices = data["mapChoices"] as? [String],
              let correct = data["correct"] as? String else {
            return nil
        }
        
        self.id = documentID
        self.question = question
        self.mapChoices = mapChoices
        self.correct = correct
    }
}
