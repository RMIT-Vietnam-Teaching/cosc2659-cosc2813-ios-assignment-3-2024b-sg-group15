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
            
            VStack(spacing: 60) {
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
                    ForEach(Array(zip(questionVM.choices.indices, questionVM.choices)), id: \.0) { index, choice in
                        ChoiceButton(correct: $correct,  question: questionVM.question as! MultipleChoiceQuestion, selected: $selected, index: index)
                    }
                }
                
                Button("Tiếp tục") {
                    // Handle game completion
                }
                //                    .padding()
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                .scaleEffect(selected != "" ? 1 : 0.5) // Adjust the scale effect for animation
                .opacity(selected != "" ? 1 : 0)
                
            }
            .padding(horizontalSizeClass == .compact ? 10 : 30)
            
        }
    }
}

//#Preview {
//    MultipleChoiceView()
//}
