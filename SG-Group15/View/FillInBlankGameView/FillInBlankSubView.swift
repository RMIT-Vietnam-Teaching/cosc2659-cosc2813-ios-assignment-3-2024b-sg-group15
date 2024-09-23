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

// MARK: - Subviews



// SentenceView: Displays the sentence with blanks and filled words
struct SentenceView: View {
    // Observed object to react to changes in the view model
    @ObservedObject var viewModel: FillInBlankViewModel
    // Environment variable to determine the current size class
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        TappableTextView(segments: createTappableSegments()) { index in
                    viewModel.removeWordFromBlank(at: index)
                } isWordCorrect: { index in
                    viewModel.isWordCorrect(at: index)
                }
            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(QuestionTextModifier()) : AnyViewModifier(QuestionTextModifierIpad()))
            .lineSpacing(10.0)
            .padding()
            .cornerRadius(10)
            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(QuestionTextModifier()) : AnyViewModifier(QuestionTextModifierIpad()))
        
        // Apply different text modifiers based on device size
    }
    
    // Helper function to create tappable segments for the sentence
    private func createTappableSegments() -> [TappableTextSegment] {
        var segments: [TappableTextSegment] = []
        
        for (index, part) in viewModel.sentenceParts.enumerated() {
            // Add non-tappable text segment
            segments.append(TappableTextSegment(text: part, isTappable: false))
            
            if index < viewModel.blanks.count {
                if let filledWord = viewModel.blanks[index].filledWord {
                    // Add tappable filled word segment
                    segments.append(TappableTextSegment(text: filledWord.text, isTappable: true, index: index))
                } else {
                    // Add non-tappable blank segment
                    segments.append(TappableTextSegment(text: "_________", isTappable: false))
                }
            }
            
            // Add space between words, except for the last word
            if index < viewModel.sentenceParts.count - 1 {
                segments.append(TappableTextSegment(text: " ", isTappable: false))
            }
        }
        
        return segments
    }
}
// WordsView: Displays the available words for filling in the blanks
struct WordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    let word: Word
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            // Word background
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.darkRed, lineWidth: horizontalSizeClass == .compact ? 3 : 4)
                .frame(width: width, height: height)
            
            // Word text
            Text(word.text)
                .minimumScaleFactor(0.3)
                .lineLimit(2)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(8)
        }
        .frame(width: width, height: height)
        // Reduce opacity if the word is already placed
        .opacity(word.isPlaced ? 0.5 : 1)
    }
}

struct WordsView: View {
    @ObservedObject var viewModel: FillInBlankViewModel
    let wordWidth: CGFloat
    let wordHeight: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    private var columns: [GridItem] {
        let columnCount = min(3, max(2, (viewModel.words.count + 1) / 2))
        return Array(repeating: GridItem(.flexible(), spacing: width * 0.02), count: columnCount)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: width * 0.05) {
            ForEach(viewModel.words) { word in
                WordView(word: word, width: wordWidth, height: wordHeight)
                    .onTapGesture { viewModel.toggleWordPlacement(word) }
            }
        }
        .padding()
    }
}

// CheckAnswerButton: Button to check the answer when all blanks are filled
struct CheckAnswerButton: View {
    let isGameComplete: Bool
    let action: () -> Void
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        if isGameComplete {
            Button("Submit", action: action)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
        }
    }
}
