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

                        .onTapGesture {
                            goToMain()
                            print("click back")
                        }
                        .frame(width: horizontalSizeClass == .compact ? 15 : 30, height: horizontalSizeClass == .compact ? 15 : 30)
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
                
            }
            .padding(10)
            
        }
    }
    
    func goToMain() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}


