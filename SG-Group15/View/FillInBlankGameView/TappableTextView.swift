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


// A custom text view that allows tapping on certain segments

struct TappableTextView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let segments: [TappableTextSegment]
    let onTap: (Int) -> Void
    let isWordCorrect: (Int) -> Bool?
    
    var body: some View {
        Text(getAttributedString())
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
            .environment(\.openURL, OpenURLAction { url in
                if url.scheme == "tappable", let index = Int(url.host ?? "") {
                    onTap(index)
                }
                return .handled
            })
    }
    
    private func getAttributedString() -> AttributedString {
        var fullString = AttributedString()
        
        for segment in segments {
            var segmentString = AttributedString(segment.text)
            if segment.isTappable, let index = segment.index {
                segmentString.foregroundColor = .black
                segmentString.inlinePresentationIntent = .stronglyEmphasized

                segmentString.link = URL(string: "tappable://\(index)")
                
                if let isCorrect = isWordCorrect(index) {
                    segmentString.backgroundColor = isCorrect ? .correctBackground : .lightRed
                    segmentString.inlinePresentationIntent = .stronglyEmphasized

                }
            } else if segment.text == "_________" {
                segmentString.foregroundColor = .gray
            }
            fullString += segmentString
        }
        
        return fullString
    }
}
