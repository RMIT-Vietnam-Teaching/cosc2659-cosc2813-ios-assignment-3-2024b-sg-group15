//
//  EventView.swift
//  SG-Group15
//
//  Created by Xian on 18/9/24.
//

import Foundation
import SwiftUI

struct EventView: View {
    @Binding var event: TimelineEvent
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            // Event border
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.darkRed, lineWidth: 3)
                .frame(width: width, height: height)
            
            // Event text
            Text(event.name)
                .modifier(BodyTextModifier())
                .foregroundColor(.black)
                .multilineTextAlignment(.center) // Center align for better readability
                .minimumScaleFactor(0.5) // Allow text to shrink to 50% of its original size
                .lineLimit(3) // Limit to 3 lines
                .padding(8)
        }
        .frame(width: width, height: height) // Ensure the ZStack takes up the full size
    }
}

