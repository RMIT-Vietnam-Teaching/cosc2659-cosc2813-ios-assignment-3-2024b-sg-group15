//
//  QuestionVMFactory.swift
//  SG-Group15
//
//  Created by Xian on 19/9/24.
//

import Foundation
// Create appropriate VM - Follow Factory design pattern
protocol QuestionViewModelFactory {
    func createViewModel(for question: QuestionProtocol) -> QuestionViewModel
}
