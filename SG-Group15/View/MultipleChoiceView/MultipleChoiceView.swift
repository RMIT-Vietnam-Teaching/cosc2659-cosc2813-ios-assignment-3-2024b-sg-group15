//
//  MultipleChoiceView.swift
//  SG-Group15
//
//  Created by Nana on 18/9/24.
//

import SwiftUI

struct MultipleChoiceView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @State private var question = MultipleChoiceQuestion(question: "Điền thêm từ còn thiếu trong nhận định của Đảng ta tại Hội nghị Trung Ương 5/1941: \"Cuộc cách mạng Đông Dương trong giai đoạn hiện tại là một cuộc cách mạng ...\"", choices: [
        "tư sản dân quyền", "dân chủ tư sản", "xã hội chủ nghĩa", "dân tộc giải phóng"
    ], correct: "dân tộc giải phóng")
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
                
                Text(question.question)
                    .lineSpacing(horizontalSizeClass == .compact ? 20.0 : 30.0)
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(HeadlineTextModifier()) : AnyViewModifier(HeadlineTextModifierIpad()))
                
                VStack(spacing: 40) {
                    ForEach(Array(zip(question.choices.indices, question.choices)), id: \.0) { index, choice in
                        ChoiceButton(correct: $correct, question: $question, selected: $selected, index: index)
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
