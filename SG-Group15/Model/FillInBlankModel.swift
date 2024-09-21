//
//  FillInBlankModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import Foundation
import SwiftUI

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
