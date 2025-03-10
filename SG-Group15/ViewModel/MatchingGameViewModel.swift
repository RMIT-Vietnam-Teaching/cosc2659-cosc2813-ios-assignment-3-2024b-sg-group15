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

import SwiftUI
import FirebaseFirestore

class MatchingGameViewModel: QuestionViewModel {
    @Published var leftEvents: [MatchingEvent] = []
    @Published var rightEvents: [MatchingEvent] = []
    @Published var selectedLeftEventId: Int?
    @Published var selectedRightEventId: Int?
    @Published var isGameComplete = false
    
    override init(question: QuestionProtocol) {
        super.init(question: question)
        if let question = question as? MatchingQuestion {
            initQuestion(question: question)
        }
    }
    
    // Initialize left and right events data
    private func initQuestion(question: MatchingQuestion) {
        self.leftEvents = question.left.enumerated().map { i, period  in
            MatchingEvent(id: i, text: period, correctMatchId: i)
        }
        self.rightEvents = question.right.enumerated().map { i, period  in
            MatchingEvent(id: i, text: period, correctMatchId: i)
        }
        self.leftEvents.shuffle()
        self.rightEvents.shuffle()
        
        
    }
    
    
    func selectLeftEvent(_ event: MatchingEvent) {
        selectedLeftEventId = event.id
        checkForMatch()
    }
    
    func selectRightEvent(_ event: MatchingEvent) {
        selectedRightEventId = event.id
        checkForMatch()
    }
    
    private func checkForMatch() {
        guard let leftId = selectedLeftEventId,
              let rightId = selectedRightEventId,
              let leftIndex = leftEvents.firstIndex(where: { $0.id == leftId }),
              let rightIndex = rightEvents.firstIndex(where: { $0.id == rightId }) else { return }
        
        let left = leftEvents[leftIndex]
        let right = rightEvents[rightIndex]
        
        if left.correctMatchId == right.correctMatchId {
            // Correct match
            leftEvents[leftIndex].isMatched = true
            rightEvents[rightIndex].isMatched = true
        } else {
            // Incorrect match
            leftEvents[leftIndex].isIncorrectMatch = true
            rightEvents[rightIndex].isIncorrectMatch = true
            
            // Reset after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.leftEvents[leftIndex].isIncorrectMatch = false
                self.rightEvents[rightIndex].isIncorrectMatch = false
                self.selectedLeftEventId = nil
                self.selectedRightEventId = nil
            }
        }
        
        // Check if all events are matched
        if leftEvents.allSatisfy({ $0.isMatched }) && rightEvents.allSatisfy({ $0.isMatched }) {
            isGameComplete = true
        }
        
        // Reset selections
        selectedLeftEventId = nil
        selectedRightEventId = nil
    }
}
