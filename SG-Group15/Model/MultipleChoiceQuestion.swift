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
