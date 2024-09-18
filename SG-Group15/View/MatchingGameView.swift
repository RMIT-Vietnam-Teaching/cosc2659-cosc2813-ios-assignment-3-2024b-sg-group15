import SwiftUI

struct MatchingGameView: View {
    @StateObject private var viewModel =  MatchingGameViewModel()
        
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let smallerDimension = min(width, height)
            
            VStack() {
                Text("Nối sự kiện dưới đây")
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
                    .modifier(LargeButtonModifier(background:.darkRed))
                }
            }
            .frame(width: width, height: height)
            .background(Color.beigeBackground.edgesIgnoringSafeArea(.all))
        }
        .onAppear {
            viewModel.fetchQuestion(from: "CuOIjLZ0nQRmAWs53mcJ")
        }
    }
}

struct MatchingGameView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingGameView()
        
    }
}
