//
//  TimelineGameModel.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/14/24.
//

import SwiftUI

struct Event: Identifiable, Equatable {
    let id: Int
    let name: String
    var position: CGPoint
    var isPlaced: Bool = false
    var currentPeriod: Int?
    var originalPosition: CGPoint
}

struct TimePeriod: Identifiable {
    let id: Int
    let period: String
    var position: CGPoint
}
