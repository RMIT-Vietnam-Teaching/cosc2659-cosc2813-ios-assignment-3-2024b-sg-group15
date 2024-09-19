//
//  DefaultQuestionVMFactory.swift
//  SG-Group15
//
//  Created by Do Le Long An on 19/9/24.
//

import Foundation

class DefaultQuestionViewModelFactory: QuestionViewModelFactory {
    func createViewModel(for question: QuestionProtocol, canFlip: Bool) -> QuestionViewModel {
        switch question.questionType {
        case .multipleChoice:
            return MutipleChoiceViewModel(question: question, canFlip: canFlip)
        case .matching:
            return MatchingGameViewModel(question: question, canFlip: canFlip)
        case .timeline:
            return TimelineGameViewModel(question: question, canFlip: canFlip)
        default:
            print("Invalid question type")
            return MutipleChoiceViewModel(question: question, canFlip: canFlip)
        }
    }
}
