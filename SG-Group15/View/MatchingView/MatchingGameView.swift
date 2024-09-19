import SwiftUI

struct MatchingGameView: View {
    @ObservedObject var questionVM: MatchingGameViewModel
        
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
                        ForEach(questionVM.leftEvents) { event in
                            EventButton(event: event,
                                        isSelected: questionVM.selectedLeftEventId == event.id,
                                        action: { questionVM.selectLeftEvent(event) },
                                        size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                        }
                    }
                    
                    // Right column
                    VStack(spacing: smallerDimension * 0.08) {
                        ForEach(questionVM.rightEvents) { event in
                            EventButton(event: event,
                                        isSelected: questionVM.selectedRightEventId == event.id,
                                        action: { questionVM.selectRightEvent(event) },
                                        size: CGSize(width: smallerDimension * 0.4, height: smallerDimension * 0.12))
                        }
                    }
                }
                .padding()
                
                if questionVM.isGameComplete {
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
    }
}

//struct MatchingGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchingGameView()
//        
//    }
//}
