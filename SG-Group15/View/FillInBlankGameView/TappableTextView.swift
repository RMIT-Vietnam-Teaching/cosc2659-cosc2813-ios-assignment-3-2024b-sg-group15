//
//  TappableTextView.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//

import SwiftUI
/// A custom text view that allows tapping on certain segments
struct TappableTextView: View {
    let segments: [TappableTextSegment]
    let onTap: (Int) -> Void
    
    var body: some View {
        Text(getAttributedString())
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
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
                segmentString.backgroundColor = .blue.opacity(0.2)
                segmentString.foregroundColor = .black
                segmentString.link = URL(string: "tappable://\(segment.index ?? -1)")
            } else if segment.text == "_________" {
                segmentString.foregroundColor = .gray
                segmentString.backgroundColor = .yellow.opacity(0.2)
            }
            fullString += segmentString
        }
        
        return fullString
    }
}
