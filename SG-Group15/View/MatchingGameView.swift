import SwiftUI

struct MatchingGameView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @StateObject private var viewModel: MatchingGameViewModel
    
    init(eventPairs: [(String, String)]) {
        _viewModel = StateObject(wrappedValue: MatchingGameViewModel(eventPairs: eventPairs))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let smallerDimension = min(width, height)
            
            ZStack(alignment: .top) {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: horizontalSizeClass == .compact ? 15 : 25, height: horizontalSizeClass == .compact ? 15 : 25)
                        ProgressBar()
                    }
                    .padding(.horizontal, 20)
                    
                    Text("Nối sự kiện dưới đây")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(QuestionTextModifier()) : AnyViewModifier(QuestionTextModifierIpad()))
                        .padding()
                    
                    HStack(spacing: smallerDimension * 0.08) {
                        // Left column
                        VStack(spacing: smallerDimension * 0.05) {
                            ForEach(viewModel.leftEvents) { event in
                                EventButton(event: event,
                                            isSelected: viewModel.selectedLeftEventId == event.id,
                                            action: { viewModel.selectLeftEvent(event) },
                                            size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                            }
                        }
                        
                        // Right column
                        VStack(spacing: smallerDimension * 0.05) {
                            ForEach(viewModel.rightEvents) { event in
                                EventButton(event: event,
                                            isSelected: viewModel.selectedRightEventId == event.id,
                                            action: { viewModel.selectRightEvent(event) },
                                            size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                            }
                        }
                    }
                    .padding()
                    
                    Button("Tiếp tục") {
                        // Handle game completion
                    }
//                    .padding()
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                    .scaleEffect(viewModel.isGameComplete ? 1 : 0.5) // Adjust the scale effect for animation
                    .opacity(viewModel.isGameComplete ? 1 : 0)
                    
                }
                .padding(.top, 20)
            }
            .frame(width: width, height: height)

        }
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

struct MatchingGameView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingGameView(eventPairs: [
            ("Chiến dịch Điện Biên Phủ", "CTTGT2 kết thúc"),
            ("Event 2 Left", "Event 2 Right"),
            ("Event 3 Left", "Event 3 Right"),
            ("Event 4 Left", "Event 4 Right"),
            ("Event 5 Left", "Event 5 Right")
        ])
        
    }
}
