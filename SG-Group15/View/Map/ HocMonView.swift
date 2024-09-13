import SwiftUI


struct HocMonView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Xuân Thới Thượng", 0.25, 0.111, 0.25, 0.17, 0.14, 0.3, 0.23, 0.3, 2.0, 2.4, 2.4),
        ("Bà Điểm", 0.6, 0.4, 0.65, 0.45, 0.7, 0.5, 0.75, 0.55, 2.0, 2.0, 2.3),
        ("Tân Xuân", 0.2, 0.6,0.25, 0.65, 0.3, 0.7, 0.35, 0.75, 2.0, 2.0, 2.3),
        ("Xuân Thới Sơn", 0.8, 0.8,  0.85, 0.85, 0.9, 0.9, 0.95, 0.95, 2.0, 2.4, 2.3)
    ]

    var body: some View {
//        VStack {
//            Text("Orientation: \(isLandscape ? "Landscape" : "Portrait")") // Display current orientation
//                .font(.headline)
//                .padding()
//            
            MapComponent(mapImage: "HocMon", mapPoints: mapPoints
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


struct MapGameView_Previews: PreviewProvider {
    static var previews: some View {
        HocMonView()
          
    }
}
