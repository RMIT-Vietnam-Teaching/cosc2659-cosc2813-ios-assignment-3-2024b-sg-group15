//
//  TimePeriodView.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation
import SwiftUI

struct TimePeriodView: View {
    @Binding var period: TimePeriod
    let width: CGFloat
    let height: CGFloat
    let isEven: Bool
    let screenWidth: CGFloat
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var body: some View {
        HStack {
            // Alternate layout for even/odd periods
            if isEven {
                periodContent
                destinationBox
            } else {
                destinationBox
                periodContent
            }
        }
    }
    
    var periodContent: some View {
        VStack(alignment: isEven ? .leading : .trailing, spacing: 0) {
            // Period text
            Text(period.period)
                .modifier(BodyTextModifier())
            // Horizontal line
            Rectangle()
                .fill(Color.black)
                .frame(height: 3)
                .frame(width: screenWidth * 0.5)
            
        }.offset(y: isIpad ? -25 : -10)
    }
    
    var destinationBox: some View {
        // Dashed box for event placement
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.darkRed, style: StrokeStyle(lineWidth: 3, dash: [5]))
            .frame(width: width, height: height)
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        // Set position for the period
                        let frame = geo.frame(in: .named("gameArea"))
                        period.position = CGPoint(x: frame.midX, y: frame.midY)
                    }
                }
            )
    }
}
