import SwiftUI

struct MatchingGameView: View {
    @StateObject private var viewModel: MatchingGameViewModel
    
    init(eventPairs: [(String, String)]) {
        _viewModel = StateObject(wrappedValue: MatchingGameViewModel(eventPairs: eventPairs))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let smallerDimension = min(width, height)
            
            VStack() {
                Text("Nối sự kiện dưới đây")
//                    .font(.system(size: smallerDimension * 0.04))
                    .modifier(TitleTextModifier())
                    .padding()
                
                HStack(spacing: smallerDimension * 0.03) {
                    // Left column
                    VStack(spacing: smallerDimension * 0.08) {
                        ForEach(viewModel.leftEvents) { event in
                            EventButton(event: event,
                                        isSelected: viewModel.selectedLeftEventId == event.id,
                                        action: { viewModel.selectLeftEvent(event) },
                                        size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                        }
                    }
                    
                    // Right column
                    VStack(spacing: smallerDimension * 0.08) {
                        ForEach(viewModel.rightEvents) { event in
                            EventButton(event: event,
                                        isSelected: viewModel.selectedRightEventId == event.id,
                                        action: { viewModel.selectRightEvent(event) },
                                        size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                        }
                    }
                }
                .padding()
                
                if viewModel.isGameComplete {
                    Button("Tiếp tục") {
                        // Handle game completion
                    }
                    .padding()
//                    .frame(width: smallerDimension * 0.3, height: smallerDimension * 0.08)
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
                    .modifier(LargeButtonModifier(background:.darkRed))
                }
            }
            .frame(width: width, height: height)
            .background(Color.beigeBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct EventButton: View {
    let event: MatchingEvent
    let isSelected: Bool
    let action: () -> Void
    let size: CGSize
    
    var body: some View {
        Button(action: action) {
            Text(event.text)
                .padding(size.width * 0.05)
                .frame(width: size.width, height: size.height * 1.2)
                .background(backgroundForState())
                .foregroundColor(foregroundForState())
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.darkRed, lineWidth: 2)
                )
//                .font(.system(size: size.height * 0.25))
                .modifier(BodyTextModifier())
                .minimumScaleFactor(0.5)
                .lineLimit(3)
        }
        .disabled(event.isMatched)
    }
    
    private func backgroundForState() -> Color {
        if event.isMatched {
            return .green
        } else if event.isIncorrectMatch {
            return .red
        } else if isSelected {
            return .darkRed.opacity(0.3)
        } else {
            return .white
        }
    }
    
    private func foregroundForState() -> Color {
        if event.isMatched || event.isIncorrectMatch {
            return .white
        } else {
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
