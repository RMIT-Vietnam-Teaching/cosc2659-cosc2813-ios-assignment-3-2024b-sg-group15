//
//  FillInBlankViewModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import Foundation
// FillInBlankViewModel.swift

import SwiftUI

// MARK: - Database connect Demo | replace until init function
//    @Published var words: [Word] = []
//    @Published var blanks: [Blank] = []
//    @Published var sentenceParts: [String] = []
//    @Published var isGameComplete = false
//    @Published var question: FillInBlankQuestion?
//    
//    private var db = Firestore.firestore()
//    
//    func fetchQuestion(from documentID: String) {
//        db.collection("questions").document(documentID).getDocument { [weak self] document, error in
//            if let error = error {
//                print("Error fetching document: \(error)")
//                return
//            }
//            
//            guard let document = document, document.exists,
//                  let data = document.data(),
//                  let question = FillInBlankQuestion(documentID: document.documentID, data: data) else {
//                print("Document does not exist or is invalid")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self?.question = question
//                self?.initQuestion()
//            }
//        }
//    }
//    
//    private func initQuestion() {
//        guard let question = question else { return }
//        
//        self.words = question.words.map { Word(text: $0, isPlaced: false) }
//        let parts = question.sentence.components(separatedBy: "......")
//        self.sentenceParts = parts
//        self.blanks = zip(parts.indices, question.correctWords).compactMap { index, correctWord in
//            index < parts.count - 1 ? Blank(index: index, correctWord: correctWord) : nil
//        }
//    }


class FillInBlankViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var words: [Word]
    @Published var blanks: [Blank]
    @Published var sentenceParts: [String]
    @Published var isGameComplete = false
    @Published var isAnswerChecked = false
    @Published var correctSentence: String

        // MARK: - Initialization
        
        /// Initializes the view model with the game data
        /// - Parameters:
        ///   - words: Array of words to be used in the game
        ///   - sentence: The sentence with blanks (represented by "......")
        ///   - correctWords: Array of correct words for each blank
        ///   - correctSentence: The fully correct sentence
        init(words: [String], sentence: String, correctWords: [String], correctSentence: String) {
            self.words = words.map { Word(text: $0, isPlaced: false) }
            let parts = sentence.components(separatedBy: "......")
            self.sentenceParts = parts
            self.blanks = zip(parts.indices, correctWords).compactMap { index, correctWord in
                index < parts.count - 1 ? Blank(index: index, correctWord: correctWord) : nil
            }
            self.correctSentence = correctSentence
        }
    
    // MARK: - Game Logic
    
    /// Toggles the placement of a word
    /// - Parameter word: The word to be toggled
    func toggleWordPlacement(_ word: Word) {
        if word.isPlaced {
            removeWord(word)
        } else {
            placeWord(word)
        }
    }
    
    /// Places a word in the first available blank
    /// - Parameter word: The word to be placed
    private func placeWord(_ word: Word) {
        guard !word.isPlaced,
              let index = words.firstIndex(where: { $0.id == word.id }),
              let blankIndex = blanks.firstIndex(where: { $0.filledWord == nil }) else { return }
        
        words[index].isPlaced = true
        blanks[blankIndex].filledWord = words[index]
        checkGameCompletion()
    }
    
    /// Removes a word from its blank
    /// - Parameter word: The word to be removed
    private func removeWord(_ word: Word) {
        guard let wordIndex = words.firstIndex(where: { $0.id == word.id }),
              let blankIndex = blanks.firstIndex(where: { $0.filledWord?.id == word.id }) else { return }
        
        words[wordIndex].isPlaced = false
        blanks[blankIndex].filledWord = nil
        checkGameCompletion()
    }
    
    /// Removes a word from a specific blank
    /// - Parameter index: The index of the blank
    func removeWordFromBlank(at index: Int) {
        guard index < blanks.count, let filledWord = blanks[index].filledWord else { return }
        removeWord(filledWord)
    }
    
    /// Checks if all blanks are filled
    private func checkGameCompletion() {
        isGameComplete = blanks.allSatisfy { $0.filledWord != nil }
    }
    
    /// Checks the correctness of the filled words
    /// - Returns: A tuple containing the number of correct answers and total blanks
    func checkAnswer() {
            isAnswerChecked = true
            objectWillChange.send()
        }

        func isWordCorrect(at index: Int) -> Bool? {
            guard isAnswerChecked, index < blanks.count else { return nil }
            return blanks[index].filledWord?.text == blanks[index].correctWord
        }
    func resetGame() {
            // Reset blanks
            for index in blanks.indices {
                if let word = blanks[index].filledWord {
                    if let wordIndex = words.firstIndex(where: { $0.text == word.text }) {
                        words[wordIndex].isPlaced = false
                    }
                    blanks[index].filledWord = nil
                }
            }
            isGameComplete = false
        }
}
