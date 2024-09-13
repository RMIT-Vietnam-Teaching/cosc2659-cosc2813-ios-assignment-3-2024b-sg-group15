//
//  MapTextResizer.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 13/9/24.
//

import Foundation
import SwiftUI

struct MapComponent: View {
    // Updated map points with place names, proportional coordinates, and custom size multipliers
    let mapImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular:CGFloat)]
    // Map points with custom x, y values for each device type and orientation
       
    @State private var isSelected: String?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // To check the device type
    @Environment(\.verticalSizeClass) var verticalSizeClass : UserInterfaceSizeClass? // For detecting landscape or portrait
    @State private var selectedButton: String? = nil
    let isLandscape: Bool 
    
    var body: some View {
        GeometryReader { geo in
            Text("horizontalSizeClass: \(horizontalSizeClass == .compact ? "Compact" : "Regular"), verticalSizeClass: \(verticalSizeClass == .compact ? "Compact" : "Regular")")
                   
            // The image of the map
            Image(mapImage) // Replace with your map image asset
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack {
                        ForEach(mapPoints, id: \.name) { point in
                            Button(action: {
                                selectedButton = point.name
                            }) {
                                Text(point.name) // Display the actual place name
                                    .frame(
                                        width: customButtonWidth(for: geo.size, multiplier: point.sizeMultiplier, landscapeMultiplierCompact: point.landscapeMultiplierCompact, landscapeMultiplierRegular: point.landscapeMultiplierRegular),
                                              height: customButtonHeight(for: geo.size, multiplier: point.sizeMultiplier, landscapeMultiplierCompact: point.landscapeMultiplierCompact, landscapeMultiplierRegular: point.landscapeMultiplierRegular)
                                    )
                                    
                                    .foregroundColor(selectedButton == point.name ? .brown : .black)
                                    .cornerRadius(10)
                                    .font(.system(size: dynamicTextSize(), weight: selectedButton == point.name ? .heavy : .semibold, design: .rounded) // Adjust text size based on device
                                     // Shrinks the text if too long
//                                    .multilineTextAlignment(.center)
                                          )
                            }
                            // Position the button at the correct spot
                            .position(
                                
                              
                          
                                    x: calculateXPosition(
                                        for: geo.size.width,
                                        point: (point.name, point.compactX, point.compactY, point.regularX, point.regularY, point.landscapeCompactX, point.landscapeCompactY, point.landscapeRegularX, point.landscapeRegularY, point.sizeMultiplier)
                                        ,isLandscape: isLandscape // Pass isLandscape here
                                    ),
                                    y: calculateYPosition(
                                        for: geo.size.height,
                                        point: (point.name, point.compactX, point.compactY, point.regularX, point.regularY, point.landscapeCompactX, point.landscapeCompactY, point.landscapeRegularX, point.landscapeRegularY, point.sizeMultiplier)
                                        ,isLandscape: isLandscape // Pass isLandscape here
                                    
                                )

                                

                            )
                        }
                    }
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .aspectRatio(contentMode: .fit)
                .padding()
        }
        .edgesIgnoringSafeArea(.all) // To fill the screen if needed
    }
    
    // Function to calculate button width based on device type and orientation
    func customButtonWidth(for size: CGSize, multiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat) -> CGFloat {
        let baseWidth: CGFloat
        if verticalSizeClass == .compact {
            // Landscape mode
            baseWidth = horizontalSizeClass == .compact ? size.width * 0.25 * landscapeMultiplierCompact : size.width * 0.35 * landscapeMultiplierRegular
        } else {
            // Portrait mode
            baseWidth = horizontalSizeClass == .compact ? size.width * 0.2 : size.width * 0.3
        }
        return baseWidth * multiplier
    }

    // Function to calculate button height based on device type and orientation
    func customButtonHeight(for size: CGSize, multiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat) -> CGFloat {
        let baseHeight: CGFloat
        if verticalSizeClass == .compact {
            // Landscape mode
            baseHeight = horizontalSizeClass == .compact ? size.height * 0.02 * landscapeMultiplierCompact : size.height * 0.06 * landscapeMultiplierRegular
        } else {
            // Portrait mode
            baseHeight = horizontalSizeClass == .compact ? size.height * 0.02 : size.height * 0.06
        }
        return baseHeight * multiplier
    }
    
    // Dynamic text size based on whether it's an iPad or iPhone
    func dynamicTextSize() -> CGFloat {
          if verticalSizeClass == .compact {
              // Landscape mode
              return horizontalSizeClass == .compact ? 18 : 40 // Smaller text size for iPhone, larger for iPad in landscape
          } else {
              // Portrait mode
              return horizontalSizeClass == .compact ? 15 : 38 // Slightly larger text size for iPhone, even larger for iPad in portrait
          }
      }
    
//    func calculateXPosition(for width: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
//        if UIDevice.current.userInterfaceIdiom == .pad && verticalSizeClass == .compact {
//            // Handle landscape mode for iPad explicitly
//            return width * point.landscapeRegularX
//        } else if verticalSizeClass == .compact {
//            // Landscape mode for iPhone
//            return width * point.landscapeCompactX
//        } else {
//            // Portrait mode for both devices
//            return horizontalSizeClass == .compact ? width * point.compactX : width * point.regularX
//        }
//    }
//
//    func calculateYPosition(for height: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
//        if UIDevice.current.userInterfaceIdiom == .pad && verticalSizeClass == .compact {
//            // Handle landscape mode for iPad explicitly
//            return height * point.landscapeRegularY
//        } else if verticalSizeClass == .compact {
//            // Landscape mode for iPhone
//            return height * point.landscapeCompactY
//        } else {
//            // Portrait mode for both devices
//            return horizontalSizeClass == .compact ? height * point.compactY : height * point.regularY
//        }
//    }

    func calculateXPosition(
        for width: CGFloat,
        point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat),
        isLandscape: Bool
    ) -> CGFloat {
        if isLandscape {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // iPad in landscape
                return width * point.landscapeRegularX
            } else {
                // iPhone in landscape
                return width * point.landscapeCompactX
            }
        } else {
            // Portrait mode
            return horizontalSizeClass == .compact ? width * point.compactX : width * point.regularX
        }
    }

    func calculateYPosition(
        for height: CGFloat,
        point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat),
        isLandscape: Bool
    ) -> CGFloat {
        if isLandscape {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // iPad in landscape
                return height * point.landscapeRegularY
            } else {
                // iPhone in landscape
                return height * point.landscapeCompactY
            }
        } else {
            // Portrait mode
            return horizontalSizeClass == .compact ? height * point.compactY : height * point.regularY
        }
    }

    

    
}

//    // Function to calculate the x position based on the device type (compact or regular)
//    func calculateXPosition(for width: CGFloat, compactX: CGFloat, regularX: CGFloat) -> CGFloat {
//        return horizontalSizeClass == .compact ? width * compactX : width * regularX
//    }
//
//    // Function to calculate the y position based on the device type (compact or regular)
//    func calculateYPosition(for height: CGFloat, compactY: CGFloat, regularY: CGFloat) -> CGFloat {
//        return horizontalSizeClass == .compact ? height * compactY : height * regularY
//    }
    

//    // Custom button width based on device size and custom multiplier
//    func customButtonWidth(for size: CGSize, multiplier: CGFloat) -> CGFloat {
//        let baseWidth = horizontalSizeClass == .compact ? size.width * 0.2 : size.width * 0.3
//        return baseWidth * multiplier // Apply custom multiplier for each button
//    }
//
//    // Custom button height based on device size and custom multiplier
//    func customButtonHeight(for size: CGSize, multiplier: CGFloat) -> CGFloat {
//        let baseHeight = horizontalSizeClass == .compact ? size.height * 0.02 : size.height * 0.06
//        return baseHeight * multiplier // Apply custom multiplier for each button
//    }

