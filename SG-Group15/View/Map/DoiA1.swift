//
//  DoiA1.swift
//  SG-Group15
//
//  Created by Anh Nguyen Ha Kieu on 21/9/24.
//

import SwiftUI


struct DoiA1View: View {
    
    
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Bình Yên", 0.4, 0.31, 0.4, 0.51, 2.0),
        ("Tân Trào", 0.6, 0.185, 0.6, 0.3, 2.0),
        ("Trung Yên", 0.5, 0.09, 0.5, 0.15, 2.0),
        ("Minh Thanh", 0.155, 0.22, 0.15, 0.35, 2.0),
        ("Lương Thiện", 0.68, 0.35, 0.68, 0.55, 2.0)
    ]
    
    var body: some View {
        MapComponent3( mapImage: "DoiA1", mapPoints: mapPoints, correctAnswer: "Tân Trào")
    }
}

#Preview {
    DoiA1View()
}
