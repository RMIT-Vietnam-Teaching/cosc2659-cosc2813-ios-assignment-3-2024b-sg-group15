//
//  MapData.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/22/24.
//

import SwiftUI


struct MapData {
    let mapImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
    let correctAnswer: String
    let config: MapComponentConfig
}

struct MapComponentConfig {
    let animationGifName: String
    let animationDuration: Double
    let animationSize: (compact: CGSize, regular: CGSize)
    let animationPosition: (compact: CGPoint, regular: CGPoint)
    let animationOffset: CGSize
}
