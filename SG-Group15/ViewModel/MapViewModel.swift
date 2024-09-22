// MapViewModel.swift
import SwiftUI
import Combine

class MapViewModel: ObservableObject {
    // Published properties to update the UI
    @Published var question: String
    @Published var mapChoices: [String]
    @Published var correctAnswer: String
    @Published var selectedAnswer: String? = nil
    @Published var showAnimation: Bool = false
    
    // Derived property to determine the MapType based on correctAnswer
    var mapType: MapType? {
        return MapType.allCases.first { $0.rawValue == correctAnswer }
    }
    
    // Map data based on MapType
    var mapData: MapData? {
        guard let type = mapType else { return nil }
        return MapDataProvider.mapData(for: type)
    }
    
    init(question: String, mapChoices: [String], correctAnswer: String) {
        self.question = question
        self.mapChoices = mapChoices
        self.correctAnswer = correctAnswer
    }
    
    // Handle user selection
    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil else { return } // Prevent multiple selections
        selectedAnswer = answer
        showAnimation = (answer == correctAnswer)
        
        // Additional logic can be added here, such as updating scores or navigating to the next question
    }
}
