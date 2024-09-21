//
//  MultipleChoiceView.swift
//  SG-Group15
//
//  Created by Nana on 18/9/24.
//

import SwiftUI

struct MultipleChoiceView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var questionVM:  MutipleChoiceViewModel
    
    @State private var selected: String = ""
    @State private var correct: Bool?
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: horizontalSizeClass == .compact ? 50 : 100) {
                HStack(spacing: 20) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: horizontalSizeClass == .compact ? 15 : 25, height: horizontalSizeClass == .compact ? 15 : 25)
                    ProgressBar()
                }
                .padding(.horizontal, 10)
                Text(questionVM.question.question)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubTitleTextModifier()) : AnyViewModifier(LongQuestionTextModifierIpad()))
                    .lineSpacing(10.0)
                
                VStack(spacing: 20) {
                    ForEach(Array(zip(questionVM.question.choices.indices, questionVM.question.choices)), id: \.0) { index, choice in
                        ChoiceButton(correct: $correct, question: questionVM.question as! MultipleChoiceQuestion, selected: $selected, index: index)
                    }
                }
                
                Button("Tiếp tục") {
                    // Handle game completion
                }
                .foregroundColor(.white)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(RegularButtonModifier(background: .darkRed)) : AnyViewModifier(RegularButtonModifierIpad(background: .darkRed)))
                .scaleEffect(selected != "" ? 1 : 0.5) // Adjust the scale effect for animation
                .opacity(selected != "" ? 1 : 0)
                
            }
            .padding(horizontalSizeClass == .compact ? 10 : 30)
            
        }
    }
}

#Preview {
    MultipleChoiceView()
}
