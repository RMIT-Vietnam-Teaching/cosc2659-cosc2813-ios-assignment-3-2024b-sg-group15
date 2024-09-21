//
//  ChapterViewModel.swift
//  SG-Group15
//
//  Created by Xian on 19/9/24.
//

import Foundation
import FirebaseFirestore

// Manage the change of chapter
class ChapterViewModel: ObservableObject {
    @Published var chapter: Chapter?
    private var db = Firestore.firestore()
    
    // Fetch the list of questions of a chapter
    private func fetchQuestions(for chapter: Chapter) {
        // Query the questions
        db.collection("questions")
            .whereField("chapterID", isEqualTo: chapter.id)
            .getDocuments { snapshot, error in
                // Handle error
                if let error = error {
                    print("Error fetching questions: \(error)")
                    return
                }
                // Check if a chapter has any question
                guard let documents = snapshot?.documents else {
                    print("No question found")
                    return
                }
                
                var questions: [QuestionProtocol] = []
                // Decode question document to appropriate question type
                for docu in documents {
                    let data = docu.data()
                    // Create multiple choice question
                    if let multipleChoice = MultipleChoiceQuestion(documentID: docu.documentID, data: data) {
                        questions.append(multipleChoice)
                    }
                    else if let matching = MatchingQuestion(documentID: docu.documentID, data: data) {
                        questions.append(matching)
                    }
                }
                // Update the chapter question list
                DispatchQueue.main.async {
                    var updatedChapter = chapter
                    updatedChapter.questions = questions
                    self.chapter = updatedChapter
                    
                }
                
            }
    }
    
    // Fetch chapter
    func fetchChapter(from chapterID: String) {
        db.collection("chapter").document(chapterID).getDocument { [weak self] docu, error in
            // Handle error
            if let error = error {
                print("Error fetching chapter: \(error)")
                return
            }
            // Init chapter
            if let document = docu {
                if let data = document.data() {
                    let chapter = Chapter(documentID: document.documentID, data: data)
                    // Fetch questions
                    if let chapter = chapter {
                        self?.fetchQuestions(for: chapter)
                    }
                }
            }
            else {
                print("Chapter not found")
            }
            
        }
    }
    
    
}
