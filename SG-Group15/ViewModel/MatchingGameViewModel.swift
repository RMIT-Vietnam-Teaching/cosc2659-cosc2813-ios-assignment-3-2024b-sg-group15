import SwiftUI

class MatchingGameViewModel: ObservableObject {
    @Published var leftEvents: [MatchingEvent]
    @Published var rightEvents: [MatchingEvent]
    @Published var selectedLeftEventId: Int?
    @Published var selectedRightEventId: Int?
    @Published var isGameComplete = false
    
    init(eventPairs: [(String, String)]) {
        leftEvents = eventPairs.enumerated().map { MatchingEvent(id: $0, text: $1.0, correctMatchId: $0) }
        rightEvents = eventPairs.enumerated().map { MatchingEvent(id: $0 + eventPairs.count, text: $1.1, correctMatchId: $0) }
        
        leftEvents.shuffle()
        rightEvents.shuffle()
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
            withAnimation {
                isGameComplete = true
            }
        }
        
        // Reset selections
        selectedLeftEventId = nil
        selectedRightEventId = nil
    }
}

