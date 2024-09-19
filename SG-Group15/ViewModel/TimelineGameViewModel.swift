import SwiftUI
import FirebaseFirestore

class TimelineGameViewModel: QuestionViewModel {
    @Published var timePeriods: [TimePeriod] = []
    @Published var events: [TimelineEvent] = []
    @Published var isGameComplete = false
    @Published var showResult = false
    @Published var correctPlacements = 0
    
    let eventWidth: CGFloat = 170
    let eventHeight: CGFloat = 80
    let periodWidth: CGFloat = 170
    let periodHeight: CGFloat = 80
    
    override init(question: QuestionProtocol, canFlip: Bool) {
        super.init(question: question, canFlip: true)
        if let question = question as? TimelineQuestion {
            initQuestion(question: question)
        }
    }
    
    // Fetch question from database
//    func fetchQuestion(from documentID: String) {
//        db.collection("questions").document(documentID).getDocument { [weak self] document, error in
//            // Handle error
//            if let error = error {
//                print("Error fetching document: \(error)")
//            }
//            
//            // Fetch document
//            if let document = document, document.exists {
//                if let data = document.data() {
//                    let question = MatchingQuestion(documentID: document.documentID, data: data)
//                    // Set the question
//                    DispatchQueue.main.async {
//                        self?.question = question
//                        self?.initQuestion()
//                    }
//                }
//            }
//            else {
//                print("Document does not exist")
//            }
//        }
//    }
    
    // Initialize events and periods data
    private func initQuestion(question: TimelineQuestion) {
        // Add events
        self.events = question.events.enumerated().map { i, name in
            TimelineEvent(id: i, name: name, position: .zero, originalPosition: .zero)
        }
        let shuffledIndices = Array(0..<question.periods.count).shuffled()
        self.timePeriods = question.periods.enumerated().map { originalIndex, period in
            let shuffledIndex = shuffledIndices[originalIndex]
            return TimePeriod(id: originalIndex, period: period, position: .zero, displayOrder: shuffledIndex)
        }
        self.timePeriods.sort { $0.displayOrder < $1.displayOrder }
    }
    
    
    func nearestTimePeriod(to point: CGPoint) -> TimePeriod? {
        timePeriods.min(by: { distance(from: point, to: $0.position) < distance(from: point, to: $1.position) })
    }
    
    func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
    }
    
    func checkGameCompletion() {
        isGameComplete = events.allSatisfy { $0.currentPeriod != nil }
    }
    
    func checkAnswer() {
        correctPlacements = events.filter { $0.currentPeriod == $0.id }.count
        showResult = true
    }
}


