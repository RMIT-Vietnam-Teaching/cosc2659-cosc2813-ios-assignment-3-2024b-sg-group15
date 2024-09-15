//
//  BacGiang.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import SwiftUI



struct BacGiangView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Bắc Giang", 0.19, 0.155, 0.2, 0.25, 0.125, 0.49, 0.4, 0.64, 2.0, 2.4, 2.4),
        ("Lạng Sơn", 0.48, 0.13, 0.48, 0.22, 0.3, 0.38, 0.45, 0.37, 2.0, 2.0, 2.3),
        
        ("Thái Nguyên", 0.42, 0.223,  0.42, 0.366, 0.27, 0.69, 0.2, 0.44, 2.0, 2.4, 2),
        ("Quảng Ninh", 0.62, 0.267,  0.61, 0.435, 0.41, 0.83, 0.61, 0.775, 2.0, 2.4, 2.3)
    ]

    var body: some View {
            MapComponent5(isLandscape: isLandscape,mapImage: "BacGiang", mapPoints: mapPoints
                         
            )
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                        let currentOrientation = UIDevice.current.orientation
                        isLandscape = currentOrientation.isLandscape
                        
                        // Log the current orientation
                        print("Orientation changed: \(isLandscape ? "Landscape" : "Portrait")")
                    }
                }
        }
    }


#Preview {
    BacGiangView()
}



