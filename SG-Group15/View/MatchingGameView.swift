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

struct MatchingGameView: View {
    @AppStorage("theme") private var theme: Theme = .light
    @Environment(\.colorScheme) private var scheme: ColorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var viewModel: MatchingGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let smallerDimension = min(width, height)
            
            ZStack(alignment: .top) {
                Image(getEffectiveTheme(theme: theme, systemColorScheme: scheme) == .dark ? "backgroundDark" : "background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
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
                    .padding(.top, 60)
                    
                    Text("Nối sự kiện dưới đây")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(QuestionTextModifier()) : AnyViewModifier(QuestionTextModifierIpad()))
                        .padding()
                    
                    HStack(spacing: smallerDimension * 0.08) {
                        // Left column
                        VStack(spacing: smallerDimension * 0.06) {
                            ForEach(viewModel.leftEvents) { event in
                                EventButton(event: event,
                                            isSelected: viewModel.selectedLeftEventId == event.id,
                                            action: { viewModel.selectLeftEvent(event) },
                                            size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                            }
                        }
                        
                        // Right column
                        VStack(spacing: smallerDimension * 0.06) {
                            ForEach(viewModel.rightEvents) { event in
                                EventButton(event: event,
                                            isSelected: viewModel.selectedRightEventId == event.id,
                                            action: { viewModel.selectRightEvent(event) },
                                            size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                            }
                        }
                    }
                    .padding()
                    
                }
                .padding(.top, 20)
            }
            .frame(width: width, height: height)

        }
    }
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}

struct EventButton: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    let event: MatchingEvent
    let isSelected: Bool
    let action: () -> Void
    let size: CGSize
    
    var body: some View {
        Button(action: action) {
            Text(event.text)
                .frame(width: horizontalSizeClass == .compact ? 150 : 250, height: horizontalSizeClass == .compact ? 80 : 130)
                .background(backgroundForState())
                .foregroundColor(foregroundForState())
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(strokeForState(), lineWidth: horizontalSizeClass == .compact ? 2 : 3)
                )
                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))                .minimumScaleFactor(0.5)
                .lineLimit(3)
        }
        .disabled(event.isMatched)
    }
    
    private func backgroundForState() -> Color {
        if event.isMatched {
            return .correctBackground
        } else if event.isIncorrectMatch {
            return .lightRed
        } else if isSelected {
            return .butteryWhite
        } else {
            return .clear
        }
    }
    
    private func strokeForState() -> Color {
        if event.isMatched {
            return .correctText
        } else if event.isIncorrectMatch {
            return .darkRed
        } else if isSelected {
            return .black
        } else {
            return .black
        }
    }
    
    private func foregroundForState() -> Color {
        if event.isMatched {
            return .correctText
        } else if event.isIncorrectMatch {
            return .darkRed
        }
        else {
            return .black
        }
    }
}

