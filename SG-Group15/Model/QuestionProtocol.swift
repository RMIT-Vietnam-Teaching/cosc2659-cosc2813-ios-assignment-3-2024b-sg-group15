//
//  QuestionProtocol.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation

// Protocol for question: Other question types implement this protocol
protocol QuestionProtocol {
    var id: String { get }
    var question: String { get }    
}


