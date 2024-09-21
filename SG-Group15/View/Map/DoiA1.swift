//
//  DoiA1.swift
//  SG-Group15
//
//  Created by Anh Nguyen Ha Kieu on 21/9/24.
//

import SwiftUI


struct DoiA1View: View {
    
    
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Đồi D1", 0.65, 0.27, 0.4, 0.51, 2.0),
        ("Đồi Him Lam", 0.57, 0.185, 0.6, 0.3, 2.0),
        ("Đồi Độc Lập", 0.6, 0.08, 0.5, 0.15, 2.0),
        ("Đồi A1", 0.62, 0.36, 0.68, 0.55, 2.0)
    ]
    
    var body: some View {
        MapComponent6( mapImage: "DoiA1", mapPoints: mapPoints, correctAnswer: "Đồi A1")
    }
}

#Preview {
    DoiA1View()
}
