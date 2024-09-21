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
