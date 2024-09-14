import SwiftUI

class TimelineGameViewModel: ObservableObject {
    @Published var events: [TimelineEvent]
    @Published var timePeriods: [TimePeriod]
    @Published var isGameComplete = false
    @Published var showResult = false
    @Published var correctPlacements = 0
    
    let eventWidth: CGFloat = 170
    let eventHeight: CGFloat = 80
    let periodWidth: CGFloat = 170
    let periodHeight: CGFloat = 80
    
    init(eventData: [String], periodData: [String]) {
        self.events = eventData.enumerated().map { i, name in
            TimelineEvent(id: i, name: name, position: .zero, originalPosition: .zero)
        }
        
        let shuffledIndices = Array(0..<periodData.count).shuffled()
        self.timePeriods = periodData.enumerated().map { originalIndex, period in
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

