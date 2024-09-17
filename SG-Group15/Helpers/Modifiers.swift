//
//  Modifiers.swift
//  SG-Group15
//
//  Created by Xian on 11/9/24.
//

import Foundation
import SwiftUI

// Sign up button style: Add to the label
struct SignUpButtonModifier: ViewModifier {
    // Add background color as parameter
    var background: Color
    func body(content: Content) -> some View {
        content
        // Responsive frame
            .frame(minWidth: UIScreen.main.bounds.width * 0.7, maxWidth: UIScreen.main.bounds.width * 0.9)
            .font(.custom("Lato-Black", size: UIScreen.main.bounds.width * 0.06))
            .foregroundStyle(.white)
            .padding(.vertical, 15)
            .background(background)
            .cornerRadius(15)
        // Ajust shadow to be responsive
            .shadow(radius: 2, x: 1, y: UIScreen.main.bounds.width * 0.015)
    }
}

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
    var color: Color?
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Light", size: UIScreen.main.bounds.width * 0.05))
        // Can customize color
            .foregroundStyle(color ?? .textDark)
    }
}

// Body text style: Apply for content in answers
struct BodyTextModifier: ViewModifier {
    var color: Color?
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Regular", size: UIScreen.main.bounds.width * 0.045))
            .foregroundStyle(color ?? .textDark)
    }
}

// Text input field style: For login and signup
struct TextInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.textDark)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .frame(minWidth: UIScreen.main.bounds.width * 0.7, maxWidth: UIScreen.main.bounds.width * 0.9)
        // Prevent auto-correct user input
            .autocorrectionDisabled()
            .shadow(radius: 2, x: 1, y: UIScreen.main.bounds.width * 0.015)
        // Disable auto capitalization
            .textInputAutocapitalization(.never)
    }
}

struct ShadowTopBottom: ViewModifier {
    var alignment: Alignment
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .background(
               // Adding shadow to the bottom edge
               RoundedRectangle(cornerRadius: 15)
                   .fill(Color.black.opacity(0.2)) // Shadow color
                   .frame(height: 10) // Shadow height
                   .blur(radius: 5) // Blur for soft shadow
                   .offset(x: x, y: y), // Position the shadow
               alignment: alignment
           )
    }
}

struct ShadowLeftRight: ViewModifier {
    var alignment: Alignment
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .background(
               // Adding shadow to the bottom edge
               RoundedRectangle(cornerRadius: 15)
                   .fill(Color.black.opacity(0.2)) // Shadow color
                   .frame(width: 10) // Shadow height
                   .blur(radius: 5) // Blur for soft shadow
                   .offset(x: x, y: y), // Position the shadow
               alignment: alignment
           )
    }
}


