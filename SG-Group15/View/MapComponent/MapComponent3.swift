//
//  MapComponent3.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 15/9/24.
//

import Foundation

import SwiftUI

struct MapComponent3: View {
    let mapImage: String
//    let animationImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
    // Map points with custom x, y values for each device type
    
    @State private var isSelected: String?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // To check the device type
    let correctAnswer: String // The correct answer
    @State private var animationOffset = CGSize.zero
    @State private var selectedButton: String? = nil
    @State private var showResults = false
    @State private var showAnimationImage = false // Tracks if the animation image should be shown
    // Offset for slide animation
    @State private var animationOpacity = 0.0 // For fading in
    @State private var animationScale: CGFloat = 0.5 // For scaling the image
    @State private var isFighting = true
    var body: some View {
        GeometryReader { geo in
            // The image of the map
            Image(mapImage)
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack {
                        ForEach(mapPoints, id: \.name) { point in
                            
                          
                                
                                Button(action: {
                                    handleSelection(for: point.name, positionX: calculateXPosition(for: geo.size.width, point: point),
                                                    positionY: calculateYPosition(for: geo.size.height, point: point))
                                }) {
                                    Text(point.name)
                                        .frame(
                                            width: customButtonWidth(for: geo.size, multiplier: point.sizeMultiplier),
                                            height: customButtonHeight(for: geo.size, multiplier: point.sizeMultiplier)
                                        )
                                    //                                    .foregroundColor(selectedButton == point.name ? .brown : .black)
                                        .foregroundColor(buttonTextColor(for: point.name))
                                        .cornerRadius(10)
                                        .font(.system(size: dynamicTextSize(), weight: .semibold
                                                      // selectedButton == point.name ? .heavy : .semibold
                                                      , design: .rounded)
                                        )
                                }
                                // Position the button at the correct spot
                                .position(
                                    x: calculateXPosition(for: geo.size.width, point: point),
                                    y: calculateYPosition(for: geo.size.height, point: point)
                                )
                                .disabled(isSelectionMade())
                            
                            if showAnimationImage {
                                ZStack{
                                    GifImageView("explosion", duration: 8, isVisible: $isFighting)
                                        .frame(width: 100, height: 100)
//                                        .offset(animationOffset) 
                                        .position(x: horizontalSizeClass == .compact ? 210 : 490, y: geo.size.height * getCorrectYPosition())
                                                                        }}
                        }}
                          
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 10)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // Handle the button click logic and slide-in animation
      func handleSelection(for name: String, positionX: CGFloat, positionY: CGFloat) {
          if selectedButton == nil {
              selectedButton = name
              showResults = true
              showAnimationImage = true
            
                      
          }
      }
    
    // Get the X position of the correct answer
    func getCorrectXPosition() -> CGFloat {
        let correctPoint = mapPoints.first { $0.name == correctAnswer }
        return horizontalSizeClass == .compact ? correctPoint!.compactX : correctPoint!.regularX
    }
    
    // Get the Y position of the correct answer
    func getCorrectYPosition() -> CGFloat {
        let correctPoint = mapPoints.first { $0.name == correctAnswer }
        return horizontalSizeClass == .compact ? correctPoint!.compactY : correctPoint!.regularY
    }
    
    // Check if the selection has been made
    func isSelectionMade() -> Bool {
        return selectedButton != nil
    }
    
    // Define the text color for buttons based on the selection state
    func buttonTextColor(for name: String) -> Color {
        guard let selected = selectedButton else {
            return .black
        }
        if name == correctAnswer {
            return .green
        } else {
            return .red
        }
    }
    
    // Function to calculate the X position of the button
    func calculateXPosition(for width: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
        return horizontalSizeClass == .compact ? width * point.compactX : width * point.regularX
    }
    
    // Function to calculate the Y position of the button
    func calculateYPosition(for height: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
        return horizontalSizeClass == .compact ? height * point.compactY : height * point.regularY
    }
    
    
    // Function to calculate button width based on device type and orientation
    func customButtonWidth(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseWidth = horizontalSizeClass == .compact ? size.width * 0.15 : size.width * 0.15
        
        return baseWidth * multiplier
    }

    // Function to calculate button height based on device type and orientation
    func customButtonHeight(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseHeight = horizontalSizeClass == .compact ? size.height * 0.05 : size.height * 0.07
       
        return baseHeight * multiplier
    }
    
    // Dynamic text size based on whether it's an iPad or iPhone
    func dynamicTextSize() -> CGFloat {
       
              // Portrait mode
              return horizontalSizeClass == .compact ? 17 : 44
          
      }
}


