//
//  DefaultQuestionVMFactory.swift
//  SG-Group15
//
//  Created by Xian on 19/9/24.
//

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
