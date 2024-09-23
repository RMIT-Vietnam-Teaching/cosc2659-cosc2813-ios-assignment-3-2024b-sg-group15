/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 15
    - Nguyen Tran Ha Anh - 3938490
    - Bui Tuan Anh - 3970375
    - Nguyen Ha Kieu Anh - 3818552
    - Truong Hong Van - 3957034
  Created  date: 08/09/2024
  Last modified: 23/09/2024
*/

import SwiftUI

struct MapComponent: View {
    let mapImage: String
    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)]
    let correctAnswer: String
    let config: MapComponentConfig
    
    @ObservedObject var viewModel: MapViewModel
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(
        viewModel: MapViewModel,
        mapImage: String,
        mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)],
        correctAnswer: String,
        config: MapComponentConfig
    ) {
        self.viewModel = viewModel
        self.mapImage = mapImage
        self.mapPoints = mapPoints
        self.correctAnswer = correctAnswer
        self.config = config
    }
    
    var body: some View {
        GeometryReader { geo in
            Image(mapImage)
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack {
                        mapPointsOverlay(in: geo)
                        animationOverlay(in: geo)
                    }
                )
                .frame(width: geo.size.width, height: geo.size.height)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 10)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func mapPointsOverlay(in geometry: GeometryProxy) -> some View {
        ForEach(mapPoints, id: \.name) { point in
            if !(point.name == correctAnswer && viewModel.showAnimation) {
                Button(action: {
                    viewModel.selectAnswer(point.name)
                }) {
                    Text(point.name)
                        .frame(
                            width: customButtonWidth(for: geometry.size, multiplier: point.sizeMultiplier),
                            height: customButtonHeight(for: geometry.size, multiplier: point.sizeMultiplier)
                        )
                        .foregroundColor(buttonTextColor(for: point.name))
                        .cornerRadius(10)
                        .font(.system(size: dynamicTextSize(), weight: .semibold, design: .rounded))
                }
                .position(
                    x: calculateXPosition(for: geometry.size.width, point: point),
                    y: calculateYPosition(for: geometry.size.height, point: point)
                )
                .disabled(viewModel.selectedAnswer != nil)
            }
        }
    }
    
    private func animationOverlay(in geometry: GeometryProxy) -> some View {
        Group {
            if viewModel.showAnimation, let mapData = viewModel.mapData {
                GifImageView(
                    mapData.config.animationGifName,
                    duration: mapData.config.animationDuration,
                    isVisible: $viewModel.showAnimation
                )
                
                .frame(width: animationSize.width, height: animationSize.height)
                .offset(animationOffset)
                .position(x: animationPosition.x, y: animationPosition.y)
                .onAppear {
                    withAnimation(.easeInOut(duration: config.animationDuration)) {
                        // Reset offset to zero to animate into position
                        // Note: The GifImageView handles hiding itself after duration
                        // So we don't need to manage it here
                    }
                }
            }
        }
    }
    
    private var animationSize: CGSize {
        horizontalSizeClass == .compact ? config.animationSize.compact : config.animationSize.regular
    }
    
    private var animationPosition: CGPoint {
        horizontalSizeClass == .compact ? config.animationPosition.compact : config.animationPosition.regular
    }
    
    private var animationOffset: CGSize {
        config.animationOffset
    }
    
    private func buttonTextColor(for name: String) -> Color {
        guard viewModel.selectedAnswer != nil else { return .black }
        return name == correctAnswer ? .green : .red
    }
    
    private func customButtonWidth(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseWidth = horizontalSizeClass == .compact ? size.width * 0.13 : size.width * 0.14
        return baseWidth * multiplier
    }
    
    private func customButtonHeight(for size: CGSize, multiplier: CGFloat) -> CGFloat {
        let baseHeight = horizontalSizeClass == .compact ? size.height * 0.03 : size.height * 0.05
        return baseHeight * multiplier
    }
    
    private func calculateXPosition(for width: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
        return horizontalSizeClass == .compact ? width * point.compactX : width * point.regularX
    }
    
    private func calculateYPosition(for height: CGFloat, point: (name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)) -> CGFloat {
        return horizontalSizeClass == .compact ? height * point.compactY : height * point.regularY
    }
    
    private func dynamicTextSize() -> CGFloat {
        return horizontalSizeClass == .compact ? 14 : 24
    }
}

