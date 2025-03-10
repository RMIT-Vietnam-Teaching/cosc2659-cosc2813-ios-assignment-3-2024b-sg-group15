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

import Foundation
import FirebaseFirestore

class BookViewModel: ObservableObject {
    @Published var chapters: [Chapter] = []
    private var db = Firestore.firestore()
    @Published var isLoading: Bool = true

    // Fetch the list of chapters for a given book
    func fetchBook(bookID: String) {
        db.collection("chapters")
            .whereField("bookID", isEqualTo: bookID)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching chapters: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No chapters found")
                    return
                }
                
                var fetchedChapters: [Chapter] = []
                let group = DispatchGroup() // To handle async fetching for all chapters
                
                for document in documents {
                    let data = document.data()
                    if var chapter = Chapter(documentID: document.documentID, data: data) {
                        fetchedChapters.append(chapter)
                        print(chapter.id)
                        // Append an empty question to handle cover page
                        chapter.questions.append(MultipleChoiceQuestion(id: "", question: "", choices: [], correct: ""))
                        // Fetch questions for each chapter
                        group.enter() // Enter dispatch group
                        self?.fetchQuestions(for: chapter) { fetchedQuestions in
                            if let index = fetchedChapters.firstIndex(where: { $0.id == chapter.id }) {
                                fetchedChapters[index].questions = fetchedQuestions
                            }
                            group.leave() // Leave dispatch group after questions are fetched
                        }
                    }
                }
                
                // Wait for all fetches to complete
                group.notify(queue: .main) {
                    // Sort chapters by the 'order' field
                    fetchedChapters.sort { (first: Chapter, second: Chapter) -> Bool in
                        return first.odrer < second.odrer
                     }
                    // Update the chapters with all the data and set loading to false
                    self?.chapters = fetchedChapters
                    self?.isLoading = false // Data is fully loaded
                    print("Fetched \(fetchedChapters.count) chapters with questions")
                }
            }
    }
        
    // Fetch the list of questions of a chapter
    private func fetchQuestions(for chapter: Chapter, completion: @escaping ([QuestionProtocol]) -> Void) {
        // Query the questions
        db.collection("questions")
            .whereField("chapterID", isEqualTo: chapter.id)
            .getDocuments { snapshot, error in
                // Handle error
                if let error = error {
                    print("Error fetching questions: \(error)")
                    // Return an empty array if there's an error
                    completion([])
                    return
                }
                
                // Check if a chapter has any questions
                guard let documents = snapshot?.documents else {
                    print("No question found")
                    completion([]) // Return an empty array if no questions found
                    return
                }
                
                var questions: [QuestionProtocol] = []
                // Decode each document into the appropriate question type
                for docu in documents {
                    let data = docu.data()
                    
                    // Create a MultipleChoiceQuestion
                    if let multipleChoice = MultipleChoiceQuestion(documentID: docu.documentID, data: data) {
                        questions.append(multipleChoice)
                        print("MultipleChoiceQuestion fetched")
                    }
                    // Create a MatchingQuestion
                    else if let matching = MatchingQuestion(documentID: docu.documentID, data: data) {
                        questions.append(matching)
                        print("MatchingQuestion fetched")
                    }
                    
                    // Create Fillintheblank question
                    else if let fill = FillInBlank(documentID: docu.documentID, data: data) {
                        questions.append(fill)
                        print("FillInTheBlankQuestion fetched")
                    }
                    
                    // Create Map question
                    else if let map = MapQuestion(documentID: docu.documentID, data: data) {
                        questions.append(map)
                        print("Map question fetched")
                    }
                }
                
                // Pass the fetched questions to the completion handler
                completion(questions)
            }
    }
}
