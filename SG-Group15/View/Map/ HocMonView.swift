import SwiftUI

struct HocMonView: View {
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Xuân Thới Thượng", 0.35, 0.212, 0.3, 0.34, 2.0),
        ("Bà Điểm", 0.7, 0.28, 0.7, 0.45, 2.0),
        ("Tân Xuân", 0.7, 0.14, 0.72, 0.24, 2.0),
        ("Xuân Thới Sơn", 0.25, 0.112,  0.25, 0.18, 2.0)
    ]
    
    var body: some View {
        MapComponent1(mapImage: "HocMon", animationImage: "cover", mapPoints: mapPoints, correctAnswer: "Xuân Thới Thượng")
    }
}

#Preview {
    HocMonView()
}
