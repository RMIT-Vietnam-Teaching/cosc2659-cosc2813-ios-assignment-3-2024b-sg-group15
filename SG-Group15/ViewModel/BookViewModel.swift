import Foundation
import FirebaseFirestore

class BookViewModel: ObservableObject {
    @Published var chapters: [Chapter] = []
    private var db = Firestore.firestore()
    
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
                for document in documents {
                    let data = document.data()
                    if let chapter = Chapter(documentID: document.documentID, data: data) {
                        fetchedChapters.append(chapter)
                        print(chapter.id)
                    }
                }
                
//                self?.chapters = fetchedChapters
//                if let chapters = self?.chapters {
//                    print(chapters.count)
//                }
//                // Fetch questions for each chapter
//                self?.fetchQuestionsForChapters()
//                if let chapters = self?.chapters {
//                    print(chapters[0].questions.count)
//                }
                // Update the chapters once all are fetched
               
                           DispatchQueue.main.async {
                               self?.chapters = fetchedChapters
                               if let chapters = self?.chapters {
                                   print("Fetched \(chapters.count) chapters")
                               }
                               
                               // Fetch questions for each chapter
                               self?.fetchQuestionsForChapters()
                           }
                           
            }
    }
    
    private func fetchQuestionsForChapters() {
        for chapter in chapters {
            fetchQuestions(for: chapter)
            print("Questions fetched")
        }
    }
    
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
                        print("Question fetched")
                    }
                    else if let matching = MatchingQuestion(documentID: docu.documentID, data: data) {
                        questions.append(matching)
                        print("Question fetched")
                    }
                    else if let timeline = TimelineQuestion(documentID: docu.documentID, data: data) {
                        questions.append(timeline)
                        print("Question fetched")
                    }
                }
                // Update the chapter's questions
                if let index = self.chapters.firstIndex(where: { $0.id == chapter.id }) {
                    self.chapters[index].questions = questions
                }
                
            }
    }
}
