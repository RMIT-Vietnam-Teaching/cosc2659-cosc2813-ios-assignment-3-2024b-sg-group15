//
//  MultipleChoiceViewIpad.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct MultipleChoiceViewIpad: View {
    @State private var question = MultipleChoiceQuestion(question: "Điền thêm từ còn thiếu trong nhận định của Đảng ta tại Hội nghị Trung Ương 5/1941: \"Cuộc cách mạng Đông Dương trong giai đoạn hiện tại là một cuộc cách mạng ...\"", choices: [
        "tư sản dân quyền", "dân chủ tư sản", "xã hội chủ nghĩa", "dân tộc giải phóng"
    ], correct: "dân tộc giải phóng")
    @State private var selected: String = ""
    @State private var correct: Bool?
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(spacing: 60) {
    //                Spacer()
                    HStack(spacing: 20) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        ProgressBar()
                    }
                    
                    Text(question.question)
                        .font(.largeTitle)
//                        .modifier(BodyTextModifier())
                        .lineSpacing(10.0)
                    
                    VStack(spacing: 30) {
                        ForEach(Array(zip(question.choices.indices, question.choices)), id: \.0) { index, choice in
                            ChoiceButton(correct: $correct, question: $question, selected: $selected, index: index)
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 50)
            .frame(height: UIScreen.main.bounds.height)
        }
    }
}

#Preview {
    MultipleChoiceViewIpad()
}
