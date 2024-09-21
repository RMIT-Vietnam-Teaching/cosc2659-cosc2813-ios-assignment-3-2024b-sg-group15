//
//  HongCumView.swift
//  SG-Group15
//
//  Created by Anh Nguyen Ha Kieu on 21/9/24.
//

import SwiftUI

struct HongCumView: View {
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Bản Hồng Cúm", 0.4, 0.31, 0.4, 0.51, 2.0),
        ("Bản Ta Po", 0.68, 0.15, 0.6, 0.3, 2.0),
        ("Bản Ban", 0.6, 0.04, 0.5, 0.15, 2.0),
        ("Bản Tem", 0.155, 0.22, 0.15, 0.35, 2.0),
        ("Bản Hồng Lai", 0.62, 0.34, 0.68, 0.55, 2.0)
    ]
    
    var body: some View {
        MapComponent3( mapImage: "DoiA1", mapPoints: mapPoints, correctAnswer: "Tân Trào")
    }
}

#Preview {
    HongCumView()
}
