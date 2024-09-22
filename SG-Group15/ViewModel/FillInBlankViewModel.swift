//
//  FillInBlankViewModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import Foundation
// FillInBlankViewModel.swift

import SwiftUI
import FirebaseFirestore

class FillInBlankViewModel: QuestionViewModel {
    // MARK: - Published properties
    @Published var words: [Word]=[]
    @Published var blanks: [Blank]=[]
    @Published var sentenceParts: [String]=[]
    @Published var isGameComplete = false
    @Published var isAnswerChecked = false
    @Published var correctSentence: String=""
    
    // MARK: - Initialization
    override init(question: QuestionProtocol) {
        super.init(question: question)
        if let question = question as? FillInBlank {
            self.words = question.words.map { Word(text: $0, isPlaced: false) }
            let parts = question.sentence.components(separatedBy: "......")
            self.sentenceParts = parts
            self.blanks = zip(parts.indices, question.correctWords).compactMap { index, correctWord in
                index < parts.count - 1 ? Blank(index: index, correctWord: correctWord) : nil
            }
            self.correctSentence = correctSentence
            print("Init fill in the blank")
        }
    }
        
        
        // Test question - Delete later
        //        private var db = Firestore.firestore()
        //
        //        func fetchQuestion(from documentID: String) {
        //            db.collection("questions").document(documentID).getDocument { [weak self] document, error in
        //                if let error = error {
        //                    print("Error fetching document: \(error)")
        //                    return
        //                }
        //
        //                guard let document = document, document.exists,
        //                      let data = document.data(),
        //                      let question = FillInBlank(documentID: document.documentID, data: data) else {
        //                    print("Document does not exist or is invalid")
        //                    return
        //                }
        //
        //                DispatchQueue.main.async {
        //                    self?.question = question
        //                    self?.initQuestion()
        //                }
        //            }
        //        }
        //
        //        private func initQuestion() {
        //            guard let question = question else { return }
        //            self.words = question.words.map { Word(text: $0, isPlaced: false) }
        //            let parts = question.sentence.components(separatedBy: "......")
        //            self.sentenceParts = parts
        //            self.blanks = zip(parts.indices, question.correctWords).compactMap { index, correctWord in
        //                index < parts.count - 1 ? Blank(index: index, correctWord: correctWord) : nil
        //            }
        //        }
        
        // MARK: - Game Logic
        
        // Toggles the placement of a word
        func toggleWordPlacement(_ word: Word) {
            if word.isPlaced {
                removeWord(word)
            } else {
                placeWord(word)
            }
        }
        
        // Places a word in the first available blank
        private func placeWord(_ word: Word) {
            guard !word.isPlaced,
                  let index = words.firstIndex(where: { $0.id == word.id }),
                  let blankIndex = blanks.firstIndex(where: { $0.filledWord == nil }) else { return }
            
            words[index].isPlaced = true
            blanks[blankIndex].filledWord = words[index]
            checkGameCompletion()
        }
        
        // Removes a word from its blank
        private func removeWord(_ word: Word) {
            guard let wordIndex = words.firstIndex(where: { $0.id == word.id }),
                  let blankIndex = blanks.firstIndex(where: { $0.filledWord?.id == word.id }) else { return }
            
            words[wordIndex].isPlaced = false
            blanks[blankIndex].filledWord = nil
            checkGameCompletion()
        }
        
        // Removes a word from a specific blank
        func removeWordFromBlank(at index: Int) {
            guard index < blanks.count, let filledWord = blanks[index].filledWord else { return }
            removeWord(filledWord)
        }
        
        // Checks if all blanks are filled
        private func checkGameCompletion() {
            isGameComplete = blanks.allSatisfy { $0.filledWord != nil }
        }
        
        // Checks the correctness of the filled words
        // - Returns: A tuple containing the number of correct answers and total blanks
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
