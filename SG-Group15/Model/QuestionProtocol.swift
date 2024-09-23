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
