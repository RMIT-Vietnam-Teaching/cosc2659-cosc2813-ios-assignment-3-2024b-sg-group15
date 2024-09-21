//
//  BacGiang.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import SwiftUI

struct BacGiangView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape
    
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Bắc Giang", 0.19, 0.155, 0.2, 0.25, 2.0),
        ("Lạng Sơn", 0.48, 0.13, 0.48, 0.22, 2.0),
        ("Thái Nguyên", 0.42, 0.223, 0.42, 0.366, 2.0),
        ("Quảng Ninh", 0.62, 0.267, 0.61, 0.435, 2.0)
    ]
    
    var body: some View {
        MapComponent5(mapImage: "BacGiang", mapPoints: mapPoints, correctAnswer: "Bắc Giang")
           
            
    }
}
#Preview {
    BacGiangView()
}



