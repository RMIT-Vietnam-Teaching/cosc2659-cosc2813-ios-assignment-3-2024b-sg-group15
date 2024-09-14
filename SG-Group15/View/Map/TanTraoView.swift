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
        ("Bình Yên", 0.4, 0.31, 0.42, 0.5, 0.2, 0.61, 0.3, 0.6, 2.0, 2.4, 2.4),
        ("Tân Trào", 0.67, 0.185, 0.67, 0.28, 0.44, 0.78, 0.7, 0.8, 2.0, 2.0, 2.3),
        ("Trung Yên", 0.5, 0.095, 0.5, 0.16, 0.44, 0.42, 0.72, 0.44, 2.0, 2.0, 2.3),
        ("Minh Thanh", 0.17, 0.22,  0.16, 0.34, 0.16, 0.31, 0.23, 0.3, 2.0, 2.4, 2),
        ("Lương Thiện", 0.68, 0.35,  0.68, 0.55, 0.16, 0.31, 0.23, 0.3, 2.0, 2.4, 2.3)
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
