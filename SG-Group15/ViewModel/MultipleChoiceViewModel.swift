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
import FirebaseFirestore
import SwiftUI

class MutipleChoiceViewModel: QuestionViewModel {
    @Published var choices: [String] = []
    
    override init(question: QuestionProtocol) {
        super.init(question: question)
        
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
