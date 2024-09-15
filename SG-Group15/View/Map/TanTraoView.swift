//
//  TanTraoView.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import SwiftUI


struct TanTraoView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Bình Yên", 0.4, 0.31, 0.4, 0.51, 0.2, 0.7, 0.32, 0.7, 2.0, 2.4, 2.4),
        ("Tân Trào", 0.6, 0.185, 0.6, 0.3, 0.3, 0.43, 0.45, 0.43, 2.0, 2.0, 2.3),
        ("Trung Yên", 0.5, 0.09, 0.5, 0.15, 0.24, 0.2, 0.4, 0.2, 2.0, 2.0, 2.3),
        ("Minh Thanh", 0.155, 0.22,  0.15, 0.35, 0.075, 0.5, 0.12, 0.49, 2.0, 2.4, 2),
        ("Lương Thiện", 0.68, 0.35,  0.68, 0.55, 0.34, 0.8, 0.53, 0.78, 2.0, 2.4, 2.3)
    ]

    var body: some View {
//        VStack {
//            Text("Orientation: \(isLandscape ? "Landscape" : "Portrait")") // Display current orientation
//                .font(.headline)
//                .padding()
//
            MapComponent3(isLandscape: isLandscape,mapImage: "TanTrao", mapPoints: mapPoints
                         
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
//}


#Preview {
    TanTraoView()
}
