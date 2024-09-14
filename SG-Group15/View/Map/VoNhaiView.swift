//
//  VoNhaiView.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 14/9/24.
//

import SwiftUI


struct VoNhaiView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Quỳnh Sơn", 0.72, 0.05, 0.3, 0.34, 0.2, 0.61, 0.3, 0.6, 2.0, 2.4, 2.4),
        ("Tân Hương", 0.35, 0.212, 0.3, 0.34, 0.2, 0.61, 0.3, 0.6, 2.0, 2.4, 2.4),
        ("Bắc Sơn", 0.7, 0.113, 0.72, 0.24, 0.44, 0.42, 0.72, 0.44, 2.0, 2.0, 2.3),
        ("Tân lập", 0.25, 0.112,  0.25, 0.18, 0.16, 0.31, 0.23, 0.3, 2.0, 2.4, 2.3),
        ("Hưng Vũ", 0.7, 0.28, 0.7, 0.45, 0.44, 0.78, 0.7, 0.8, 2.0, 2.0, 2.3),
        ("Vũ Lăng", 0.7, 0.28, 0.7, 0.45, 0.44, 0.78, 0.7, 0.8, 2.0, 2.0, 2.3)
    ]

    var body: some View {
            MapComponent2(mapImage: "VoNhai", mapPoints: mapPoints
                         , isLandscape: isLandscape
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


struct VoNhaiView_Previews: PreviewProvider {
    static var previews: some View {
        VoNhaiView()
          
    }
}
