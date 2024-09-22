//
//  QuestionViewModel.swift
//  SG-Group15
//
//  Created by Xian on 19/9/24.
//

import Foundation

// Parent for different types of questions VM
class QuestionViewModel: ObservableObject, Identifiable {
    @Published var question: QuestionProtocol
    
    init (question: QuestionProtocol) {
        self.question = question
    }
}
