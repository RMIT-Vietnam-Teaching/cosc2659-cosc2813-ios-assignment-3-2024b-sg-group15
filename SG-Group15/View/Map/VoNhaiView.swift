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
        ("Quỳnh Sơn", 0.7, 0.06, 0.7, 0.095, 0.345, 0.12, 0.56, 0.115, 2.0, 2.4, 2.4),
        ("Tân Hương", 0.16, 0.27, 0.14, 0.45, 0.074, 0.63, 0.3, 0.7, 2.0, 2.4, 2.4),
        ("Bắc Sơn", 0.67, 0.13, 0.68, 0.19, 0.335, 0.265, 0.53, 0.28, 2.0, 2.0, 2),
        ("Tân lập", 0.29, 0.15,  0.28, 0.25, 0.14, 0.35, 0.23, 0.35, 2.0, 2.4, 2.3),
        ("Hữu Vĩnh", 0.47, 0.12,  0.48, 0.2, 0.234, 0.26, 0.38, 0.26, 2.0, 2.4, 2.3),
        ("Hưng Vũ", 0.74, 0.22,  0.75, 0.35, 0.36, 0.5, 0.6, 0.5, 2.0, 2.4, 2.3),
        ("Vũ Làng", 0.38, 0.32,  0.38, 0.52, 0.19, 0.7, 0.12, 0.62, 2.0, 2.4, 2.3),
    ]

    var body: some View {
            MapComponent2(isLandscape: isLandscape, mapImage: "VoNhai", mapPoints: mapPoints
                         
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
