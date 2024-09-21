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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var isSubmitted = false
    let correctSentence: String
        
    init(words: [String], sentence: String, correctWords: [String], correctSentence: String) {
        _viewModel = StateObject(wrappedValue: FillInBlankViewModel(words: words, sentence: sentence, correctWords: correctWords))
        self.correctSentence = correctSentence
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let wordWidth = min(width * 0.25, 250)
            let wordHeight = min(height * 0.05, 200)
            
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Progress bar at the top
                    HStack(spacing: 10) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: horizontalSizeClass == .compact ? 15 : 25, height: horizontalSizeClass == .compact ? 15 : 25)
                        ProgressBar()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    
                    // Centering other elements
                    
                    VStack(spacing: 60) {
                        Text("Fill in the blanks with the correct words")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                            .padding(.vertical,50)

                        
                        SentenceView(viewModel: viewModel)
                            .padding(.horizontal)
                        if isSubmitted {
                                Text(correctSentence)
                                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                                    .padding()
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                        }
                        WordsView(viewModel: viewModel, wordWidth: wordWidth, wordHeight: wordHeight,width: width,height: height)
                        Spacer()
                        CheckAnswerButton(isGameComplete: viewModel.isGameComplete) {
                            viewModel.checkAnswer()
                            isSubmitted = true
                        }
                    }
                    
                    Spacer()
                }
               
            }
        }
    }
}






#Preview {
    FillInBlankGameView(
        words: ["Nhật-Pháp", "Trung Quốc", "Nhật", "chúng ta","Đức"],
        sentence: "Chỉ thị ......bắn nhau, và hành động của ......, ngày 12/3/1945 của Đảng đưa ra khẩu hiệu Đánh đuổi Phát xít ...... .",
        correctWords: ["Nhật-Pháp","chúng ta","Nhật"],
        correctSentence: "Chỉ thị Nhật-Pháp bắn nhau, và hành động của chúng ta, ngày 12/3/1945 của Đảng đưa ra khẩu hiệu Đánh đuổi Phát xít Nhật."
    )
}
