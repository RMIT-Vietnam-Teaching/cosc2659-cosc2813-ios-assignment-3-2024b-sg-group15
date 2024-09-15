//
//  DongNaiThuongView.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import SwiftUI


struct DongNaiThuongView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Tiên Hoàng", 0.45, 0.31, 0.45, 0.5, 0.19, 0.62, 0.3, 0.62, 2.0, 2.4, 2.4),
        ("Đồng Nai Thượng", 0.6, 0.185, 0.55, 0.3, 0.24, 0.365, 0.385, 0.37, 2.0, 2.0, 2.3),
        
        ("Gia Viễn", 0.18, 0.41,  0.18, 0.67, 0.075, 0.83, 0.125, 0.84, 2.0, 2.4, 2),
        ("Nam ninh", 0.43, 0.405,  0.43, 0.65, 0.18, 0.82, 0.3, 0.82, 2.0, 2.4, 2.3)
    ]

    var body: some View {
            MapComponent4(isLandscape: isLandscape,mapImage: "DongNaiThuong", mapPoints: mapPoints
                         
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
    DongNaiThuongView()
}


