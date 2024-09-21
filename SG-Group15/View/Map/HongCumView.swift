//
//  HongCumView.swift
//  SG-Group15
//
//  Created by Anh Nguyen Ha Kieu on 21/9/24.
//

import SwiftUI

struct HongCumView: View {
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Bản Hồng Cúm", 0.7, 0.7, 0.6, 0.9, 2.0),
        ("Bản Ta Po", 0.63, 0.1, 0.53, 0.14, 2.0),
        ("Bản Ban", 0.84, 0.25, 0.7, 0.32, 2.0),
        ("Bản Tem", 0.155, 0.4, 0.12, 0.53, 2.0),
        ("Bản Hồng Lai", 0.85, 0.4, 0.75, 0.5, 2.0)
    ]
    
    var body: some View {
        MapComponent7( mapImage: "DoiA1", mapPoints: mapPoints, correctAnswer: "Bản Hồng Cúm")
    }
}

#Preview {
    HongCumView()
}
