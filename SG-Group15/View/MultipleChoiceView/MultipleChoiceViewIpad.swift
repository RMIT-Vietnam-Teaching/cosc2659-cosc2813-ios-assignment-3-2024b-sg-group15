//
//  MultipleChoiceViewIpad.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct MultipleChoiceViewIpad: View {
    @StateObject private var questionViewModel = MutipleChoiceViewModel()
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
                    HStack(spacing: 20) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        ProgressBar()
                    }
                    if let question = questionViewModel.question {
                        Text(question.question)
                            .font(.largeTitle)
                        //                        .modifier(BodyTextModifier())
                            .lineSpacing(10.0)
                        
                        VStack(spacing: 30) {
                            ForEach(Array(zip(question.choices.indices, question.choices)), id: \.0) { index, choice in
                                ChoiceButton(correct: $correct, question: question, selected: $selected, index: index)
                            }
                        }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 50)
            .frame(height: UIScreen.main.bounds.height)
        }
        .onAppear {
            questionViewModel.fetchQuestion(from: "fzvfhxi9oDPnsocS16r8")
        }
    }
}

#Preview {
    MultipleChoiceViewIpad()
}
