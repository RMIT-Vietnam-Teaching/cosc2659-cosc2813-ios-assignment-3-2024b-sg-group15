//
//  Question.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import Foundation

struct MultipleChoiceQuestion: Identifiable {
    var id: UUID = UUID()
    var question: String
    var choices: [String]
    var correct: String
}
