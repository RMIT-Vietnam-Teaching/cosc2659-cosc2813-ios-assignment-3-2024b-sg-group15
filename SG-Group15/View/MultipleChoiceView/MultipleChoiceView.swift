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
            }
            .padding(horizontalSizeClass == .compact ? 10 : 30)
            .padding(.vertical, 60)
            
        }

    }
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
    

}


