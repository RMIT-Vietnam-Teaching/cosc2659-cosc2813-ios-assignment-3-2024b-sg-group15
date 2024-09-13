import SwiftUI

struct MapGameView: View {
    // Updated map points with place names, proportional coordinates, and custom size multipliers
    let mapPoints: [(name: String, x: CGFloat, y: CGFloat, sizeMultiplier: CGFloat)] = [
        ("Xuan Thoi Thuong", 0.3, 0.2, 2.0),
        ("Ba Diem", 0.6, 0.4, 1.8),
        ("Tan An", 0.2, 0.6, 1.8),
        ("Xuan Thoi An", 0.8, 0.8, 1.8)
    ]
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // To check the device type
    
    var body: some View {
        GeometryReader { geo in
            // The image of the map
            Image("HocMon") // Replace with your map image asset
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack {
                        ForEach(mapPoints, id: \.name) { point in
                            Button(action: {
                                print("Selected: \(point.name)")
                            }) {
                                Text(point.name) // Display the actual place name
                                    .frame(
                                        width: customButtonWidth(for: geo.size, multiplier: point.sizeMultiplier),
                                        height: customButtonHeight(for: geo.size, multiplier: point.sizeMultiplier)
                                    )
                                    
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .font(.system(size: dynamicTextSize())) // Adjust text size based on device
                                     // Shrinks the text if too long
//                                    .multilineTextAlignment(.center)
                            }
                            // Position the button at the correct spot
                            .position(
                                x: geo.size.width * point.x,
                                y: geo.size.height * point.y
                            )
                        }
                    }
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .aspectRatio(contentMode: .fit)
        }
        .edgesIgnoringSafeArea(.all) // To fill the screen if needed
    }
    
    // Custom button width based on device size and custom multiplier
    func customButtonWidth(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseWidth = horizontalSizeClass == .compact ? size.width * 0.04 : size.width * 0.12
        return baseWidth * multiplier // Apply custom multiplier for each button
    }
    
    // Custom button height based on device size and custom multiplier
    func customButtonHeight(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseHeight = horizontalSizeClass == .compact ? size.height * 0.02 : size.height * 0.06
        return baseHeight * multiplier // Apply custom multiplier for each button
    }
    
    // Dynamic text size based on whether it's an iPad or iPhone
    func dynamicTextSize() -> CGFloat {
        if horizontalSizeClass == .compact {
            return 14// Smaller text size for iPhones
        } else {
            return 30 // Larger text size for iPads
        }
    }
}

struct MapGameView_Previews: PreviewProvider {
    static var previews: some View {
        MapGameView()
            .previewDevice("iPad Pro (12.9-inch)")
    }
}
