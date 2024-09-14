import SwiftUI


struct HocMonView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat)] = [
        ("Xuân Thới Thượng", 0.35, 0.212, 0.3, 0.34, 0.2, 0.61, 0.3, 0.6, 2.0, 2.4, 2.4),
        ("Bà Điểm", 0.7, 0.28, 0.7, 0.45, 0.44, 0.78, 0.7, 0.8, 2.0, 2.0, 2.3),
        ("Tân Xuân", 0.7, 0.14, 0.72, 0.24, 0.44, 0.42, 0.72, 0.44, 2.0, 2.0, 2.3),
        ("Xuân Thới Sơn", 0.25, 0.112,  0.25, 0.18, 0.16, 0.31, 0.23, 0.3, 2.0, 2.4, 2.3)
    ]

    var body: some View {
//        VStack {
//            Text("Orientation: \(isLandscape ? "Landscape" : "Portrait")") // Display current orientation
//                .font(.headline)
//                .padding()
//            
            MapComponent1(isLandscape: isLandscape,mapImage: "HocMon", mapPoints: mapPoints
                         
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


struct HocMonView_Previews: PreviewProvider {
    static var previews: some View {
        HocMonView()
          
    }
}
