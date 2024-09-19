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
        super.init(question: question, canFlip: false)
        
        if let question = question as? MultipleChoiceQuestion {
            self.choices = question.choices
        }
    }
    
    
    //    // Load the question from the database
    //    func fetchQuestion(from documentID: String) {
    //        db.collection("questions").document(documentID).getDocument { [weak self] document, error in
    //            // Handle error
    //            if let error = error {
    //                print("Error fetching document: \(error)")
    //            }
    //
    //            // Fetch document
    //            if let document = document, document.exists {
    //                if let data = document.data() {
    //                    let question = MultipleChoiceQuestion(documentID: document.documentID, data: data)
    //                    // Set the question
    //                    DispatchQueue.main.async {
    //                        self?.question = question
    //                    }
    //                }
    //
    //            }
    //            else {
    //                print("Document does not exist")
    //            }
    //        }
    //    }
    //
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
