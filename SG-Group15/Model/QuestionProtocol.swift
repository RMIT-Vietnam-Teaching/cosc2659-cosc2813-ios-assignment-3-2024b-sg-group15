//
//  QuestionProtocol.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation

enum QuestionType {
    case multipleChoice
    case timeline
    case matching
    case fill
    case map
}

// Protocol for question: Other question types implement this protocol
protocol QuestionProtocol {
    var id: String { get }
    var questionType: QuestionType { get }
    var question: String { get }
}
