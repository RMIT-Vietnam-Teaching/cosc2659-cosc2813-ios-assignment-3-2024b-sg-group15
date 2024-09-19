//
//  FillInBlankView.swift
//  SG-Group15
//
//  Created by Tuan Anh Bui on 9/18/24.
//
import SwiftUI
struct FillInBlankGameView: View {
    @StateObject private var viewModel: FillInBlankViewModel
    @State private var showResultPopup = false
    @State private var result: (correct: Int, total: Int) = (0, 0)
    
    init(words: [String], sentence: String, correctWords: [String]) {
        _viewModel = StateObject(wrappedValue: FillInBlankViewModel(words: words, sentence: sentence, correctWords: correctWords))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            TitleView()
            
            SentenceView(viewModel: viewModel)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            
            WordsView(viewModel: viewModel)
            
            CheckAnswerButton(isGameComplete: viewModel.isGameComplete) {
                result = viewModel.checkAnswer()
                showResultPopup = true
            }
        }
        .overlay(
            showResultPopup ? ResultPopup(result: result, action: { showResultPopup = false }) : nil
        )
    }
}

#Preview {
    FillInBlankGameView(
        words: ["Nhật-Pháp", "Trung Quốc", "Đài Loan", "Nhật", "chúng ta"],
        sentence: "Chỉ thị ......bắn nhau, và hành động của ......, ngày 12/3/1945 của Đảng đưa ra khẩu hiệu Đánh đuổi Phát xít ...... .",
        correctWords: ["Nhật-Pháp","chúng ta","Nhật"]
    )
}
