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
                HStack(spacing: 10) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: horizontalSizeClass == .compact ? 15 : 25, height: horizontalSizeClass == .compact ? 15 : 25)
                    Spacer()
                }
                .onTapGesture {
                    goToMainPage()
                }
                .padding(.horizontal, 20)
                
                Text(questionVM.question.question)
                    .lineSpacing(horizontalSizeClass == .compact ? 20.0 : 30.0)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(HeadlineTextModifier()) : AnyViewModifier(HeadlineTextModifierIpad()))
                
                VStack(spacing: 40) {
                    ForEach(Array(zip(questionVM.choices.indices, questionVM.choices)), id: \.0) { index, choice in
                        ChoiceButton(correct: $correct,  question: questionVM.question as! MultipleChoiceQuestion, selected: $selected, index: index)
                    }
                }
                
                Button("Tiếp tục") {
                    // Handle game completion
                    goToNextPage()
                }
                .foregroundColor(.white)
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(RegularButtonModifier(background: .darkRed)) : AnyViewModifier(RegularButtonModifierIpad(background: .darkRed)))
                .scaleEffect(selected != "" ? 1 : 0.5) // Adjust the scale effect for animation
                .opacity(selected != "" ? 1 : 0)
                
            }
            .padding(horizontalSizeClass == .compact ? 10 : 30)
//            .padding(.top)
            .padding(.vertical, 60)
            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the BookView fills its parent

    }
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
    

}

//#Preview {
////    MultipleChoiceView()
//    BookView()
//}
