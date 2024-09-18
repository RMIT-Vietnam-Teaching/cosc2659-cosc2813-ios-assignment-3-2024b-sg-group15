//
//  FillInBlankModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import Foundation
import SwiftUI

struct Word: Identifiable {
    let id = UUID()
    let text: String
    var isPlaced: Bool
}

struct Blank: Identifiable {
    let id = UUID()
    let index: Int
    var filledWord: Word?
    let correctWord: String
}

struct TappableTextSegment {
    let text: String
    let isTappable: Bool
    let index: Int?
    
    init(text: String, isTappable: Bool, index: Int? = nil) {
        self.text = text
        self.isTappable = isTappable
        self.index = index
    }
}
