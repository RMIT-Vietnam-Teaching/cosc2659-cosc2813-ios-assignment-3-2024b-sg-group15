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
import SwiftUI

// Structures to form elements in the fill in the blank question type
struct Word: Identifiable {
    let id = UUID()
    let text: String
    var isPlaced: Bool
}

struct Blank: Identifiable {
    let id = UUID()
    let index: Int
    var filledWord: Word?
    let correctWord: String
}

struct TappableTextSegment {
    let text: String
    let isTappable: Bool
    let index: Int?
    
    init(text: String, isTappable: Bool, index: Int? = nil) {
        self.text = text
        self.isTappable = isTappable
        self.index = index
    }
}

// Structure to fetch question from database 
struct FillInBlank: Identifiable, QuestionProtocol {
    var id: String
    var questionType: QuestionType = .fill
    var sentence: String
    var words: [String]
    var correctWords: [String]

    init?(documentID: String, data: [String: Any]) {
        guard let sentence = data["sentence"] as? String,
              let words = data["words"] as? [String],
              let correctWords = data["correctWords"] as? [String] else {
            return nil
        }

        self.id = documentID
        self.sentence = sentence
        self.words = words
        self.correctWords = correctWords
    }
    var question: String {
        return sentence
    }
}
