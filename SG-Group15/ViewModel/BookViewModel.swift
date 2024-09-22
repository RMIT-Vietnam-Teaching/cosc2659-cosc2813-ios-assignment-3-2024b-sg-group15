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
                // Append an empty chapter to handle cover page
//                fetchedChapters.append(Chapter(id: "", title: "", description: "", questions: []))
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
                    // Create a TimelineQuestion
                    else if let timeline = TimelineQuestion(documentID: docu.documentID, data: data) {
                        questions.append(timeline)
                        print("TimelineQuestion fetched")
                    }
                }
                
                // Pass the fetched questions to the completion handler
                completion(questions)
            }
    }
}
