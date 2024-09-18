// FillInBlankSubView.swift
// SG-Group15
//
// Created by Tuan Anh Bui on 9/18/24.

import SwiftUI

// MARK: - Subviews

// TitleView: Displays the title of the "Fill in the Blank" game
struct TitleView: View {
    var body: some View {
        Text("Fill in the blanks with the correct words")
            .font(.headline)
            .padding(.horizontal)
    }
}

// SentenceView: Displays the sentence with blanks and filled words
struct SentenceView: View {
    @ObservedObject var viewModel: FillInBlankViewModel
    
    var body: some View {
        // Use a custom TappableTextView to handle tapping on filled words
        TappableTextView(segments: createTappableSegments()) { index in
            viewModel.removeWordFromBlank(at: index)
        }
    }
    
    // Helper function to create tappable segments for the sentence
    private func createTappableSegments() -> [TappableTextSegment] {
        var segments: [TappableTextSegment] = []
        
        // Iterate through sentence parts and blanks to create segments
        for (index, part) in viewModel.sentenceParts.enumerated() {
            // Add non-tappable text segment for the sentence part
            segments.append(TappableTextSegment(text: part, isTappable: false))
            
            // Add tappable segment for filled word or blank space
            if index < viewModel.blanks.count {
                if let filledWord = viewModel.blanks[index].filledWord {
                    segments.append(TappableTextSegment(text: filledWord.text, isTappable: true, index: index))
                } else {
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
struct WordsView: View {
    @ObservedObject var viewModel: FillInBlankViewModel
    
    var body: some View {
        // Use LazyVGrid for adaptive layout of word buttons
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
            ForEach(viewModel.words) { word in
                WordView(word: word)
                    .onTapGesture { viewModel.toggleWordPlacement(word) }
                    .opacity(word.isPlaced ? 0.5 : 1) // Reduce opacity for placed words
            }
        }
        .padding()
    }
}

// WordView: Displays individual word buttons
struct WordView: View {
    let word: Word
    
    var body: some View {
        Text(word.text)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.6) // Allow text to shrink if needed
            .lineLimit(3) // Limit to 3 lines maximum
    }
}

// CheckAnswerButton: Button to check the answer when all blanks are filled
struct CheckAnswerButton: View {
    let isGameComplete: Bool
    let action: () -> Void
    
    var body: some View {
        if isGameComplete {
            Button("Check Answer", action: action)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

// ResultPopup: Displays the game result and a continue button
struct ResultPopup: View {
    let result: (correct: Int, total: Int)
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Result")
                .font(.title)
            Text("\(result.correct) out of \(result.total) correct")
                .font(.headline)
            Button("Continue", action: action)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.green.opacity(0.8))
        .cornerRadius(12)
        .foregroundColor(.white)
    }
}
