//
//  DongNaiThuongView.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import SwiftUI


struct DongNaiThuongView: View {
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Tiên Hoàng", 0.45, 0.31, 0.45, 0.45, 2.0),
        ("Đồng Nai Thượng", 0.6, 0.185, 0.55, 0.275, 2.0),
        ("Gia Viễn", 0.18, 0.41, 0.18, 0.6, 2.0),
        ("Nam Ninh", 0.43, 0.405, 0.43, 0.6, 2.0)
    ]

    var body: some View {
        MapComponent4(mapImage: "DongNaiThuong",  mapPoints: mapPoints, correctAnswer: "Đồng Nai Thượng")
               
                
        }
    }


#Preview {
    DongNaiThuongView()
}


