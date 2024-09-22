//
//  MutipleChoiceViewModel.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class MutipleChoiceViewModel: QuestionViewModel {
    @Published var choices: [String] = []
    
    override init(question: QuestionProtocol, canFlip: Bool) {
        super.init(question: question, canFlip: true)
        
        if let question = question as? MultipleChoiceQuestion {
            self.choices = question.choices
        }
    }
    
    // Check if the answer is correct
    func checkAnswer(_ answer: String) -> Bool {
        // Safely unwrap question as MultipleChoiceQuestion
        guard let mcQuestion = question as? MultipleChoiceQuestion else {
            print("Question is not a MultipleChoiceQuestion.")
            return false
        }
        return mcQuestion.correct == answer
    }
}
