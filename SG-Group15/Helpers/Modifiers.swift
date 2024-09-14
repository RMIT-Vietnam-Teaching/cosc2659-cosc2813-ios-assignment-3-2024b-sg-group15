//
//  Modifiers.swift
//  SG-Group15
//
//  Created by Xian on 11/9/24.
//

import Foundation
import SwiftUI


// Large button style: Add to the label
struct LargeButtonModifier: ViewModifier {
    // Add background color as parameter
    var background: Color
    func body(content: Content) -> some View {
        content
        // Responsive frame
            .frame(minWidth: UIScreen.main.bounds.width * 0.45, maxWidth: UIScreen.main.bounds.width * 0.5)
            .font(.custom("Lato-Black", size: UIScreen.main.bounds.width * 0.06))
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .background(background)
            .cornerRadius(15)
        // Ajust shadow to be responsive
            .shadow(radius: 2, x: 1, y: UIScreen.main.bounds.width * 0.015)
    }
}

// Medium button style: Add to the label
struct MediumButtonModifier: ViewModifier {
    // Add background color as parameter
    var background: Color
    func body(content: Content) -> some View {
        content
        // Responsive frame
            .frame(minWidth: UIScreen.main.bounds.width * 0.3, maxWidth: UIScreen.main.bounds.width * 0.4)
            .font(.custom("Lato-Black", size: UIScreen.main.bounds.width * 0.5))
            .foregroundStyle(.white)
            .padding(.vertical)
            .background(background)
            .cornerRadius(15)
        // Ajust shadow to be responsive
            .shadow(radius: 2, x: 1, y: UIScreen.main.bounds.width * 0.015)
    }
}

// Title text style: Apply for book title, event title and chapter title
struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OldStandardTT-Bold", size: UIScreen.main.bounds.width * 0.06))
            .foregroundStyle(.textDark)
    }
}

// Chapter text style: Apply for book details' overview in the front page
struct HeadlineTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Light", size: UIScreen.main.bounds.width * 0.05))
            .foregroundStyle(.textDark)
    }
}

// Body text style: Apply for conten in answers
struct BodyTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Regular", size: UIScreen.main.bounds.width * 0.045))
            .foregroundStyle(.textDark)
    }
}

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
               // Adding shadow to the bottom edge
               RoundedRectangle(cornerRadius: 15)
                   .fill(Color.black.opacity(0.2)), // Shadow color
//                   .frame(height: 10) // Shadow height
//                   .blur(radius: 5) // Blur for soft shadow
//                   .offset(y: 5), // Position the shadow
               alignment: .bottom
           )
           .background(
               // Adding shadow to the right edge
               RoundedRectangle(cornerRadius: 15)
                   .fill(Color.black.opacity(0.2))
                   .frame(width: 10) // Shadow width
                   .blur(radius: 5)
                   .offset(x: 5), // Position the shadow
               alignment: .trailing
           )
    }
}



