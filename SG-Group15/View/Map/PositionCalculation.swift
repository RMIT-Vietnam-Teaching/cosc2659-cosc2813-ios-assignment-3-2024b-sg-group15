////
////  PositionCalculation.swift
////  SG-Group15
////
////  Created by Nguyen Ha Kieu Anh on 14/9/24.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//// A utility file to calculate the X and Y positions for map buttons
//
//func calculateXPosition(
//    for width: CGFloat,
//    point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat),
//    isLandscape: Bool,
//    horizontalSizeClass: UserInterfaceSizeClass? // Pass this from the calling view
//) -> CGFloat {
//    if isLandscape {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            // iPad in landscape
//            return width * point.landscapeRegularX
//        } else {
//            // iPhone in landscape
//            return width * point.landscapeCompactX
//        }
//    } else {
//        // Portrait mode
//        return horizontalSizeClass == .compact ? width * point.compactX : width * point.regularX
//    }
//}
//
//func calculateYPosition(
//    for height: CGFloat,
//    point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, landscapeCompactX: CGFloat, landscapeCompactY: CGFloat, landscapeRegularX: CGFloat, landscapeRegularY: CGFloat, sizeMultiplier: CGFloat),
//    isLandscape: Bool,
//    horizontalSizeClass: UserInterfaceSizeClass? // Pass this from the calling view
//) -> CGFloat {
//    if isLandscape {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            // iPad in landscape
//            return height * point.landscapeRegularY
//        } else {
//            // iPhone in landscape
//            return height * point.landscapeCompactY
//        }
//    } else {
//        // Portrait mode
//        return horizontalSizeClass == .compact ? height * point.compactY : height * point.regularY
//    }
//}
//
////    // Function to calculate the x position based on the device type (compact or regular)
////    func calculateXPosition(for width: CGFloat, compactX: CGFloat, regularX: CGFloat) -> CGFloat {
////        return horizontalSizeClass == .compact ? width * compactX : width * regularX
////    }
////
////    // Function to calculate the y position based on the device type (compact or regular)
////    func calculateYPosition(for height: CGFloat, compactY: CGFloat, regularY: CGFloat) -> CGFloat {
////        return horizontalSizeClass == .compact ? height * compactY : height * regularY
////    }
//    
//
////    // Custom button width based on device size and custom multiplier
////    func customButtonWidth(for size: CGSize, multiplier: CGFloat) -> CGFloat {
////        let baseWidth = horizontalSizeClass == .compact ? size.width * 0.2 : size.width * 0.3
////        return baseWidth * multiplier // Apply custom multiplier for each button
////    }
////
////    // Custom button height based on device size and custom multiplier
////    func customButtonHeight(for size: CGSize, multiplier: CGFloat) -> CGFloat {
////        let baseHeight = horizontalSizeClass == .compact ? size.height * 0.02 : size.height * 0.06
////        return baseHeight * multiplier // Apply custom multiplier for each button
////    }
