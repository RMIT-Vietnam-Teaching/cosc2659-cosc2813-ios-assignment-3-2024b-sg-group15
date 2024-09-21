import SwiftUI

// ObservableObject allows the view to listen to changes in this ViewModel
class TimelineGameViewModel: ObservableObject {
    
    // Published properties notify the view to update when their values change
    @Published var events: [TimelineEvent]               // List of timeline events
    @Published var timePeriods: [TimePeriod]            // List of time periods
    @Published var isGameComplete = false               // Flag to indicate if the game is complete
    @Published var showResult = false                   // Flag to show the result screen
    @Published var correctPlacements = 0                // Counter for correct event placements
    @Published var correctEvents: Set<Int> = []         // Set of correctly placed event IDs
    @Published var isSubmitted = false                  // Flag to indicate if the user has submitted their answer

    // Constants defining the dimensions of event and period UI elements
    let eventWidth: CGFloat = 170
    let eventHeight: CGFloat = 80
    let periodWidth: CGFloat = 170
    let periodHeight: CGFloat = 80
    
    // Initializer takes arrays of event and period names
    init(eventData: [String], periodData: [String]) {
        // Initialize events by mapping each event name to a TimelineEvent with default positions
        self.events = eventData.enumerated().map { index, name in
            TimelineEvent(
                id: index,                         // Unique identifier for the event
                name: name,                        // Name of the event
                position: .zero,                   // Current position (initialized to zero)
                originalPosition: .zero            // Original position (for reference, initialized to zero)
            )
        }
        
        // Shuffle the indices to randomize the display order of time periods
        let shuffledIndices = Array(0..<periodData.count).shuffled()
        
        // Initialize time periods by mapping each period name to a TimePeriod with shuffled display order
        self.timePeriods = periodData.enumerated().map { originalIndex, period in
            let shuffledIndex = shuffledIndices[originalIndex]   // Assign a shuffled display order
            return TimePeriod(
                id: originalIndex,                             // Unique identifier for the period
                period: period,                                // Name of the time period
                position: .zero,                               // Position on the screen (initialized to zero)
                displayOrder: shuffledIndex                    // Order in which the period is displayed
            )
        }
        
        // Sort the time periods based on the shuffled display order to randomize their arrangement
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
