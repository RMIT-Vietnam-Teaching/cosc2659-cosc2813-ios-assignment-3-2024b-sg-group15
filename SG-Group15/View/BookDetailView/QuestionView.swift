//
//import SwiftUI
//
//struct QuestionView: View {
//    @StateObject private var viewModel: QuestionViewModel
//    
//    var body: some View {
//        VStack {
//            // Display the appropriate view based on the type of question
//            
//            switch viewModel.question.questionType {
//            case .multipleChoice:
//                if let mcVM = viewModel as? MutipleChoiceViewModel {
//                    MultipleChoiceView(questionVM: mcVM)
//                }
//            case .matching:
//                if let matchingVM = viewModel as? MatchingGameViewModel {
//                    MatchingGameView(questionVM: matchingVM)
//                }
//            case .timeline:
//                if let timelineVM = viewModel as? TimelineGameViewModel {
//                    TimelineGameView(questionVM: timelineVM)
//                }
//            default:
//                Text("Undefined questionVM")
//                
//            }
//            // Add navigation or button logic (for example, to go to the next question)
//            Button(action: goToNextQuestion) {
//                Text("Next Question")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.bottom, 20)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.orange.edgesIgnoringSafeArea(.all))
//    }
//    
//    // Function to trigger navigation to the next question
//    func goToNextQuestion() {
//        NotificationCenter.default.post(name: NSNotification.Name("GoToNextQuestion"), object: nil)
//    }
//}
