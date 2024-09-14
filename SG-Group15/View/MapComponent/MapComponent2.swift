//
//  MapComponent2.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 14/9/24.
//

import Foundation

import SwiftUI

struct MapComponent2: View {
    let isLandscape: Bool
    // Updated map points with place names, proportional coordinates, and custom size multipliers
    let mapImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular:CGFloat)]
    // Map points with custom x, y values for each device type and orientation
       
    @State private var isSelected: String?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // To check the device type
    @Environment(\.verticalSizeClass) var verticalSizeClass : UserInterfaceSizeClass? // For detecting landscape or portrait
    @State private var selectedButton: String? = nil
    
    
    var body: some View {
        GeometryReader { geo in
            //Check Compact or Regular
//            Text("horizontalSizeClass: \(horizontalSizeClass == .compact ? "Compact" : "Regular"), verticalSizeClass: \(verticalSizeClass == .compact ? "Compact" : "Regular")")
                   
            // The image of the map
            Image(mapImage)
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
                                    .foregroundColor(selectedButton == point.name ? .pink : .black)
                                    .cornerRadius(10)
                                    .font(.system(size: dynamicTextSize(), weight: selectedButton == point.name ? .heavy : .semibold, design: .rounded)
                                          )
                            }
                            // Position the button at the correct spot
                            .position(
                                    x: calculateXPosition(
                                        for: geo.size.width,
                                        point: (point.name, point.compactX, point.compactY, point.regularX, point.regularY, point.landscapeCompactX, point.landscapeCompactY, point.landscapeRegularX, point.landscapeRegularY, point.sizeMultiplier)
                                        ,isLandscape: isLandscape, horizontalSizeClass: horizontalSizeClass// Pass isLandscape here
                                    ),
                                    y: calculateYPosition(
                                        for: geo.size.height,
                                        point: (point.name, point.compactX, point.compactY, point.regularX, point.regularY, point.landscapeCompactX, point.landscapeCompactY, point.landscapeRegularX, point.landscapeRegularY, point.sizeMultiplier)
                                        ,isLandscape: isLandscape, horizontalSizeClass: horizontalSizeClass // Pass isLandscape here
                                )
                            )
                        }
                    }
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 10)
        }
       
        .edgesIgnoringSafeArea(.all) // To fill the screen if needed
    }
    
    // Function to calculate button width based on device type and orientation
    func customButtonWidth(for size: CGSize, multiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat) -> CGFloat {
        let baseWidth: CGFloat
        if verticalSizeClass == .compact {
            // Landscape mode
            baseWidth = horizontalSizeClass == .compact ? size.width * 0.08 * landscapeMultiplierCompact : size.width * 0.08 * landscapeMultiplierRegular
        } else {
            // Portrait mode
            baseWidth = horizontalSizeClass == .compact ? size.width * 0.08 : size.width * 0.08
        }
        return baseWidth * multiplier
    }

    // Function to calculate button height based on device type and orientation
    func customButtonHeight(for size: CGSize, multiplier: CGFloat, landscapeMultiplierCompact: CGFloat, landscapeMultiplierRegular: CGFloat) -> CGFloat {
        let baseHeight: CGFloat
        if verticalSizeClass == .compact {
            // Landscape mode
            baseHeight = horizontalSizeClass == .compact ? size.height * 0.04 * landscapeMultiplierCompact : size.height * 0.2 * landscapeMultiplierRegular
        } else {
            // Portrait mode
            baseHeight = horizontalSizeClass == .compact ? size.height * 0.04 : size.height * 0.04
        }
        return baseHeight * multiplier
    }
    
    // Dynamic text size based on whether it's an iPad or iPhone
    func dynamicTextSize() -> CGFloat {
          if verticalSizeClass == .compact {
              // Landscape mode
              return horizontalSizeClass == .compact ? 17 : 4 // Smaller text size for iPhone, larger for iPad in landscape
          } else {
              // Portrait mode
              return horizontalSizeClass == .compact ? 18 : 40 // Slightly larger text size for iPhone, even larger for iPad in portrait
          }
      }
}


