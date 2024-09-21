//
//  Question.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import Foundation

// Model used for Map question and Multiple choice question
struct MultipleChoiceQuestion: Identifiable, QuestionProtocol {
    var id: String
    var question: String
    var choices: [String]
    var correct: String
    var questionType: QuestionType = .multipleChoice
    func checkAnswer(_ answer: String) -> Bool {
        return correct == answer
    }
    
    init(id: String, question: String, choices: [String], correct: String) {
        self.id = id
        self.question = question
        self.choices = choices
        self.correct = correct
    }
    
    
    // Initialize from database
    init?(documentID: String, data: [String: Any]) {
        guard let question = data["question"] as? String,
              let choices = data["choices"] as? [String],
              let correct = data["correct"] as? String else {
            return nil
        }
        
        self.id = documentID
        self.question = question
        self.choices = choices
        self.correct = correct
    }
}
