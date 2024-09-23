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

class TimelineGameViewModel: QuestionViewModel {
    @Published var timePeriods: [TimePeriod] = []
    @Published var events: [TimelineEvent] = []
    @Published var isGameComplete = false  // Flag to indicate if the game is complete
    @Published var showResult = false     // Flag to show the result screen
    @Published var correctPlacements = 0  // Counter for correct event placements
    @Published var correctEvents: Set<Int> = [] // Set of correctly placed event IDs
    @Published var isSubmitted = false  // Flag to indicate if the user has submitted their answer
    
    
    let eventWidth: CGFloat = 170
    let eventHeight: CGFloat = 80
    let periodWidth: CGFloat = 170
    let periodHeight: CGFloat = 80
    
    override init(question: QuestionProtocol) {
        super.init(question: question)
        if let question = question as? TimelineQuestion {
            initQuestion(question: question)
        }
    }
    
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
    
    
    // Function to check the user's answer after submission
    func checkAnswer() {
        // Determine which events are correctly placed by comparing their current period to their ID
        correctEvents = Set(events.filter { $0.currentPeriod == $0.id }.map { $0.id })
        isSubmitted = true   // Mark that the user has submitted their answer
    }
    
    // Helper function to determine if a specific event is correctly placed
    func isEventCorrect(_ event: TimelineEvent) -> Bool {
        isSubmitted && correctEvents.contains(event.id)   // Returns true if the game is submitted and the event ID is in the correct set
    }
    
    // Function to find the nearest time period to a given point (e.g., where the user dragged an event)
    func nearestTimePeriod(to point: CGPoint) -> TimePeriod? {
        // Use the minimum distance to find the closest time period
        timePeriods.min(by: {
            distance(from: point, to: $0.position) < distance(from: point, to: $1.position)
        })
    }
    
    // Helper function to calculate the Euclidean distance between two points
    func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))   // Pythagorean theorem
    }
    
    // Function to check if the game is complete by verifying all events have been assigned a period
    func checkGameCompletion() {
        // The game is complete if every event has a non-nil currentPeriod
        isGameComplete = events.allSatisfy { $0.currentPeriod != nil }
    }
    
}
