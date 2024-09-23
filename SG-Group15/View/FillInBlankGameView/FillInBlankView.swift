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

struct FillInBlankGameView: View {
    @ObservedObject var viewModel: FillInBlankViewModel
    @State private var showResultPopup = false
    @State private var result: (correct: Int, total: Int) = (0, 0)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var isSubmitted = false
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let wordWidth = min(width * 0.28, 300)
            let wordHeight = min(height * 0.06, 250)
            
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
                            .onTapGesture {
                                goToMainPage()
                            }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    // Centering other elements
                    VStack(spacing: 60) {
                        Text("Điền chữ thích hợp vào chỗ trống")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                            .padding(.vertical, 50)
                        
                        SentenceView(viewModel: viewModel)
                            .padding(.horizontal)
                        
                        if isSubmitted {
                            Text(viewModel.correctSentence)
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                                .padding()
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        WordsView(viewModel: viewModel, wordWidth: wordWidth, wordHeight: wordHeight, width: width, height: height)
                        Spacer()
//                        if isSubmitted {
//                            Button("Tiep tuc") {
//                                print("Next")
//                            }.modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
//                        } else {
//                            CheckAnswerButton(isGameComplete: viewModel.isGameComplete) {
//                                viewModel.checkAnswer()
//                                isSubmitted = true
//                            }
//                        }
                       
                        
                        
                    }
                    
                    
                    
                    Spacer()
                }
                .padding(.vertical, 60)

            }
        }
    }
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}
