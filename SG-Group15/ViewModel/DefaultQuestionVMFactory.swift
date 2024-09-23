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

class DefaultQuestionViewModelFactory: QuestionViewModelFactory {
    init() {
        
    }
    func createViewModel(for question: QuestionProtocol) -> QuestionViewModel {
        switch question.questionType {
        case .multipleChoice:
            return MutipleChoiceViewModel(question: question)
        case .matching:
            return MatchingGameViewModel(question: question)
        case .timeline:
            return TimelineGameViewModel(question: question)
        case .fill:
            return FillInBlankViewModel(question: question)
        case .map:
            return MapViewModel(question: question)
        }
    }
}
