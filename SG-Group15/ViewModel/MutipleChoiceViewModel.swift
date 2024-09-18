//
//  MutipleChoiceViewModel.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class MutipleChoiceViewModel: ObservableObject {
    @Published var question: MultipleChoiceQuestion?
    private var db = Firestore.firestore()
    
    // Load the question from the database
    func fetchQuestion(from documentID: String) {
        db.collection("questions").document(documentID).getDocument { [weak self] document, error in
            // Handle error
            if let error = error {
                print("Error fetching document: \(error)")
            }
            
            // Fetch document
            if let document = document, document.exists {
                if let data = document.data() {
                    let question = MultipleChoiceQuestion(documentID: document.documentID, data: data)
                    // Set the question
                    DispatchQueue.main.async {
                        self?.question = question
                    }
                }
                    
            }
            else {
                print("Document does not exist")
            }
        }
    }
    
    // Check if the answer is correct
    func checkAnswer(_ answer: String) -> Bool {
        if let question = self.question {
            return question.correct == answer
        }
        return false
    }
}
