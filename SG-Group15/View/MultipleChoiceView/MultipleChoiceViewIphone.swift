//
//  MultipleChoiceView.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct MultipleChoiceView: View {
    @StateObject private var questionViewModel = MutipleChoiceViewModel()
    @State private var selected: String = ""
    @State private var correct: Bool?
        
    var body: some View {
        ZStack(alignment: .top){
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                HStack(spacing: 20) {
                    Image(systemName: "xmark")
                    
                    ProgressBar()
                }
                if let question = questionViewModel.question {
                    Text(question.question)
                        .modifier(BodyTextModifier())
                        .lineSpacing(10.0)
                    
                    VStack(spacing: 20) {
                        ForEach(Array(zip(question.choices.indices, question.choices)), id: \.0) { index, choice in
                            ChoiceButton(correct: $correct, question: question, selected: $selected, index: index)
                        }
                    }
                    
                }
            }
            .padding(.top, 60)
            .padding(10)
            
        }
        .onAppear {
            questionViewModel.fetchQuestion(from: "fzvfhxi9oDPnsocS16r8")
        }
    }
}

#Preview {
    MultipleChoiceView()
}
