import SwiftUI
import FirebaseFirestore

class MatchingGameViewModel: ObservableObject {
    @Published var question: MatchingQuestion?
    @Published var leftEvents: [MatchingEvent] = []
    @Published var rightEvents: [MatchingEvent] = []
    @Published var selectedLeftEventId: Int?
    @Published var selectedRightEventId: Int?
    @Published var isGameComplete = false
    
    private var db = Firestore.firestore()
    
    // Fetch question from database
    func fetchQuestion(from documentID: String) {
        db.collection("questions").document(documentID).getDocument { [weak self] document, error in
            // Handle error
            if let error = error {
                print("Error fetching document: \(error)")
            }
            
            // Fetch document
            if let document = document, document.exists {
                if let data = document.data() {
                    let question = MatchingQuestion(documentID: document.documentID, data: data)
                    // Set the question
                    DispatchQueue.main.async {
                        self?.question = question
                        self?.initQuestion()
                    }
                }
            }
            else {
                print("Document does not exist")
            }
        }
    }
    
    // Initialize left and right events data
    private func initQuestion() {
        guard let question = question else { return }
        
        self.leftEvents = question.periods.enumerated().map { i, period  in
            MatchingEvent(id: i, text: period, correctMatchId: i)
        }
        self.rightEvents = question.events.enumerated().map { i, period  in
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

