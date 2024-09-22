////
////  MapDataModel.swift
////  SG-Group15
////
////  Created by Tuan Anh Bui on 9/22/24.
////
//
//import SwiftUI
//
//struct MapData: Identifiable {
//    let id = UUID()
//    let mapImage: String
//    let mapChoices: [String]
//    let correct: String
//    let mapQuestion: String
//    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
//}
//
//struct MapQuestion: Identifiable, QuestionProtocol {
//    var id: String
//    var question: String
//    var mapChoices: [String]
//    var correct: String
//    var mapImage: String
//    var mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
//    var questionType: QuestionType = .map
//
//    // Initialize from Firestore document ID and data
//    init?(documentID: String, data: [String: Any]) {
//        guard let question = data["question"] as? String,
//              let mapChoices = data["mapChoices"] as? [String],
//              let correct = data["correct"] as? String,
//              let mapImage = data["mapImage"] as? String,
//              let mapPointsData = data["mapPoints"] as? [[String: Any]] else {
//            return nil
//        }
//
//        self.id = documentID
//        self.question = question
//        self.mapChoices = mapChoices
//        self.correct = correct
//        self.mapImage = mapImage
//
//        // Parse mapPoints
//        self.mapPoints = mapPointsData.compactMap { pointData in
//            guard let name = pointData["name"] as? String,
//                  let compactX = pointData["compactX"] as? CGFloat,
//                  let compactY = pointData["compactY"] as? CGFloat,
//                  let regularX = pointData["regularX"] as? CGFloat,
//                  let regularY = pointData["regularY"] as? CGFloat,
//                  let sizeMultiplier = pointData["sizeMultiplier"] as? CGFloat else {
//                return nil
//            }
//            return (name, compactX, compactY, regularX, regularY, sizeMultiplier)
//        }
//    }
//}
