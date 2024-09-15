//
//  MultipleChoiceView.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct MultipleChoiceView: View {
    @State private var question = MultipleChoiceQuestion(question: "Điền thêm từ còn thiếu trong nhận định của Đảng ta tại Hội nghị Trung. ương 5/1941: \"Cuộc cách mạng Đông Dương trong giai đoạn hiện tại là một cuộc cách mạng ...\"", choices: [
        "tư sản dân quyền", "dân chủ tư sản", "xã hội chủ nghĩa", "dân tộc giải phóng"
    ], correct: "dân tộc giải phóng")
    @State private var selected: String = ""
    @State private var correct: Bool?
    
    var body: some View {
        ZStack(alignment: .top){
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
//                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "xmark")
                    
                    ProgressBar()
                }
                
                Text(question.question)
                    .modifier(BodyTextModifier())
                    .lineSpacing(10.0)
                
                VStack(spacing: 20) {
                    ForEach(Array(zip(question.choices.indices, question.choices)), id: \.0) { index, choice in
                        ChoiceButton(correct: $correct, question: $question, selected: $selected, index: index)
                    }
                }
                
            }
            .padding(.top, 60)
            .padding(10)
            
        }
    }
}

#Preview {
    MultipleChoiceView()
}
