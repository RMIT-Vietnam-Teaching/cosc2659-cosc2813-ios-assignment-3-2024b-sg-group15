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

// MapViewModel.swift
import SwiftUI
import Combine
import FirebaseFirestore

class MapViewModel: QuestionViewModel {
    // Published properties to update the UI
    @Published var mapQuestion: String = ""
    @Published var mapChoices: [String] = []
    @Published var correctAnswer: String = ""
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
    
    override init(question: QuestionProtocol) {
        super.init(question: question)
        if let question = question as? MapQuestion {
            self.mapQuestion = question.question
            self.mapChoices = question.mapChoices
            self.correctAnswer = question.correct
        }
    }
    
    // Handle user selection
    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil else { return } // Prevent multiple selections
        selectedAnswer = answer
        showAnimation = (answer == correctAnswer)
    }
    
    
  
    
}
    

