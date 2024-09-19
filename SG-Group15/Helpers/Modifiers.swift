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
            .frame(width: 200)
            .scaledFont(name: "Lato-Black", size: 24, maxSize: 30)
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .background(background)
            .cornerRadius(20)
        // Ajust shadow to be responsive
            .shadow(radius: 4, x: 1, y: UIScreen.main.bounds.width * 0.015)
    }
}

// Large button style: Add to the label
struct LargeButtonModifierIpad: ViewModifier {
    // Add background color as parameter
    var background: Color
    func body(content: Content) -> some View {
        content
        // Responsive frame
            .frame(minWidth: 350)
            .scaledFont(name: "Lato-Black", size: 36, maxSize: 40)
            .foregroundStyle(.white)
            .padding(.vertical, 20)
            .background(background)
            .cornerRadius(30)
        // Ajust shadow to be responsive
            .shadow(radius: 4, x: 1, y: UIScreen.main.bounds.width * 0.015)
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

// Medium button style: Add to the label
struct MediumButtonModifierIpad: ViewModifier {
    // Add background color as parameter
    var background: Color
    func body(content: Content) -> some View {
        content
        // Responsive frame
            .frame(minWidth: 200, maxWidth: 250)
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

struct TitleTextModifierIpad: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "OldStandardTT-Bold", size: 45, maxSize: 50)
            .foregroundStyle(.textDark)
    }
}

struct QuestionTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "OldStandardTT-Bold", size: 26, maxSize: 36)
            .foregroundStyle(.textDark)
    }
}


struct QuestionTextModifierIpad: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "OldStandardTT-Bold", size: 36, maxSize: 42)
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

struct LongQuestionTextModifier: ViewModifier {
    var color: Color?
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "OldStandardTT-Bold", size: 20, maxSize: 30)
        // Can customize color
            .foregroundStyle(color ?? .textDark)
    }
}

struct LongQuestionTextModifierIpad: ViewModifier {
    var color: Color?
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "OldStandardTT-Bold", size: 32, maxSize: 40)
        // Can customize color
            .foregroundStyle(color ?? .textDark)
    }
}

// Body text style: Apply for content in answers
struct BodyTextModifier: ViewModifier {
    var color: Color?
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "Lato-Regular", size: 16, maxSize: 18)
            .foregroundStyle(color ?? .textDark)
    }
}

// Body text style: Apply for content in answers
struct BodyTextModifierIpad: ViewModifier {
    var color: Color?
    func body(content: Content) -> some View {
        content
            .scaledFont(name: "Lato-Regular", size: 30, maxSize: 34)
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

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double
    var maxSize: Double // New property to set the maximum size

    func body(content: Content) -> some View {
        // Calculate the scaled size
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        // Ensure the scaled size does not exceed the specified max size
        let finalSize = min(scaledSize, maxSize)
        
        return content
            .font(.custom(name, size: finalSize))
            .lineLimit(nil) // Allow text to wrap into multiple lines
            .minimumScaleFactor(0.5) // Scale down if needed
            .fixedSize(horizontal: false, vertical: true) // Allow text to expand vertically
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double, maxSize: Double) -> some View {
        self.modifier(ScaledFont(name: name, size: size, maxSize: maxSize))
    }
}

// A generic view modifier that can apply any given `ViewModifier` at runtime.
struct AnyViewModifier: ViewModifier {
    
    // Stores the modifier to be applied, as a closure that returns `AnyView`.
    private let modifier: (Content) -> AnyView

    // Initializer that takes any `ViewModifier` and stores it as a type-erased closure.
    init<M: ViewModifier>(_ modifier: M) {
        self.modifier = { content in AnyView(content.modifier(modifier)) }
    }

    // This method applies the stored modifier to the content.
    func body(content: Content) -> some View {
        modifier(content)
    }
}

// Preview provider for SwiftUI canvas
struct TimelineGame_Previews: PreviewProvider {
    static var previews: some View {
        TimelineGameView(
            eventData: ["Thời cơ Cách mạng tháng 8", "Tuyên Ngôn Độc Lập", "Vua Bảo Đại thoái vị", "Chính phủ kí sắc lệnh phát hành tiền Việt Nam"],
            periodData: ["15/8/1945", "2/9/1945", "30/8/1945", "31/1/1946"]
        )
//        
        MatchingGameView(eventPairs: [
            ("Chiến dịch Điện Biên Phủ", "CTTGT2 kết thúc"),
            ("Event 2 Left", "Event 2 Right"),
            ("Event 3 Left", "Event 3 Right"),
            ("Event 4 Left", "Event 4 Right"),
            ("Event 5 Left", "Event 5 Right")
        ])
        
//        MultipleChoiceView()


    }
}
