//
//  TappableTextView.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import SwiftUI

/// A custom text view that allows tapping on certain segments
import SwiftUI

/// A custom text view that allows tapping on certain segments
struct TappableTextView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let segments: [TappableTextSegment]
    let onTap: (Int) -> Void
    
    var body: some View {
        Text(getAttributedString())
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LongQuestionTextModifier()) : AnyViewModifier(LongQuestionTextModifierIpad()))
            .environment(\.openURL, OpenURLAction { url in
                if url.scheme == "tappable", let index = Int(url.host ?? "") {
                    onTap(index)
                }
                return .handled
            })
    }
    
    /// Creates an attributed string from the segments
    private func getAttributedString() -> AttributedString {
        var fullString = AttributedString()
        
        for segment in segments {
            var segmentString = AttributedString(segment.text)
            if segment.isTappable {
                segmentString.foregroundColor = .darkRed
                segmentString.link = URL(string: "tappable://\(segment.index ?? -1)")
            } else if segment.text == "_________" {
                segmentString.foregroundColor = .gray
            }
            fullString += segmentString
        }
        
        return fullString
    }
}

// For preview and testing
struct TappableTextView_Previews: PreviewProvider {
    static var previews: some View {
        TappableTextView(segments: [
            TappableTextSegment(text: "This is ", isTappable: false),
            TappableTextSegment(text: "tappable", isTappable: true, index: 0),
            TappableTextSegment(text: " and this is ", isTappable: false),
            TappableTextSegment(text: "_________", isTappable: false),
            TappableTextSegment(text: ".", isTappable: false)
        ]) { index in
            print("Tapped index: \(index)")
        }
    }
}
