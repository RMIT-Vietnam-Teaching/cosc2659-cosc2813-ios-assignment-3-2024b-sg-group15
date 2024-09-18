import SwiftUI

struct TimelineGameView: View {
    @StateObject private var viewModel: TimelineGameViewModel
    let eventData: [String]
    let periodData: [String]
    @State private var showResultPopup = false

    init(eventData: [String], periodData: [String]) {
        self.eventData = eventData
        self.periodData = periodData
        _viewModel = StateObject(wrappedValue: TimelineGameViewModel(eventData: eventData, periodData: periodData))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let eventWidth = min(width * 0.4, 320)
            let eventHeight = height * 0.08
            let periodWidth = eventWidth
            let periodHeight = eventHeight
            
            ZStack {
                Color.beigeBackground
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Kéo các sự kiện sau đây ứng với mốc thời gian")
                        .modifier(TitleTextModifier())
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: width * 0.05) {
                        ForEach(viewModel.events.indices, id: \.self) { index in
                            Color.clear
                                .frame(width: eventWidth, height: eventHeight)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onAppear {
                                            let frame = geo.frame(in: .named("gameArea"))
                                            viewModel.events[index].originalPosition = CGPoint(x: frame.midX, y: frame.midY)
                                            if !viewModel.events[index].isPlaced {
                                                viewModel.events[index].position = viewModel.events[index].originalPosition
                                            }
                                        }
                                    }
                                )
                        }
                    }
                    .padding()
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.darkRed)
                            .frame(width: 8, height: height * 0.5)
                        VStack(spacing: height * 0.03) {
                            ForEach(viewModel.timePeriods.indices, id: \.self) { index in
                                TimePeriodView(period: $viewModel.timePeriods[index], width: periodWidth, height: periodHeight, isEven: index % 2 == 0, screenWidth: width)
                            }
                        }
                        .padding()
                    }
                }
                
                ForEach($viewModel.events) { $event in
                    EventView(event: $event, width: eventWidth, height: eventHeight)
                        .position(event.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    event.position = value.location
                                }
                                .onEnded { value in
                                    let maxDistance = eventWidth * 0.7
                                    if let nearestPeriod = viewModel.nearestTimePeriod(to: value.location) {
                                        let distance = viewModel.distance(from: value.location, to: nearestPeriod.position)
                                        if distance <= maxDistance {
                                            // Check if the period is already occupied
                                            if !viewModel.events.contains(where: { $0.id != event.id && $0.currentPeriod == nearestPeriod.id }) {
                                                event.currentPeriod = nearestPeriod.id
                                                event.isPlaced = true
                                                event.position = nearestPeriod.position
                                            } else {
                                                // Period is occupied, return event to original position
                                                event.currentPeriod = nil
                                                event.isPlaced = false
                                                withAnimation {
                                                    event.position = event.originalPosition
                                                }
                                            }
                                        } else {
                                            event.currentPeriod = nil
                                            event.isPlaced = false
                                            withAnimation {
                                                event.position = event.originalPosition
                                            }
                                        }
                                    } else {
                                        event.currentPeriod = nil
                                        event.isPlaced = false
                                        withAnimation {
                                            event.position = event.originalPosition
                                        }
                                    }
                                    viewModel.checkGameCompletion()
                                }
                        )
                }
                
                if viewModel.isGameComplete {
                   Button("Submit") {
                       viewModel.checkAnswer()
                       showResultPopup = true
                   }
                   .modifier(LargeButtonModifier(background: .darkRed))
                   .position(x: width / 2, y: height - 30)
               }
               
               if showResultPopup {
                   ResultPopupView(isCorrect: viewModel.correctPlacements == eventData.count, action: {
                       showResultPopup = false
                   })
               }
            }
            .coordinateSpace(name: "gameArea")
        }
    }
}
struct EventView: View {
    @Binding var event: TimelineEvent
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            // Event border
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.darkRed, lineWidth: 3)
                .frame(width: width, height: height)
            
            // Event text
            Text(event.name)
                .modifier(BodyTextModifier())
                .foregroundColor(.black)
                .multilineTextAlignment(.center) // Center align for better readability
                .minimumScaleFactor(0.5) // Allow text to shrink to 50% of its original size
                .lineLimit(3) // Limit to 3 lines
                .padding(8)
        }
        .frame(width: width, height: height) // Ensure the ZStack takes up the full size
    }
}

struct TimePeriodView: View {
    @Binding var period: TimePeriod
    let width: CGFloat
    let height: CGFloat
    let isEven: Bool
    let screenWidth: CGFloat
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var body: some View {
        HStack {
            // Alternate layout for even/odd periods
            if isEven {
                periodContent
                destinationBox
            } else {
                destinationBox
                periodContent
            }
        }
    }
    
    var periodContent: some View {
        VStack(alignment: isEven ? .leading : .trailing, spacing: 0) {
            // Period text
            Text(period.period)
                .modifier(BodyTextModifier())
            // Horizontal line
            Rectangle()
                .fill(Color.black)
                .frame(height: 3)
                .frame(width: screenWidth * 0.5)
                
        }.offset(y: isIpad ? -25 : -10)
    }
    
    var destinationBox: some View {
        // Dashed box for event placement
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.darkRed, style: StrokeStyle(lineWidth: 3, dash: [5]))
            .frame(width: width, height: height)
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        // Set position for the period
                        let frame = geo.frame(in: .named("gameArea"))
                        period.position = CGPoint(x: frame.midX, y: frame.midY)
                    }
                }
            )
    }
}

struct ResultPopupView: View {
    let isCorrect: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            // Result message
            Text(isCorrect ? "Bingo!" : "Liuliu sai gòi")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            
            // Continue button
            Button("Tiếp tục") {
                action()
            }
            .padding()
            .background(isCorrect ? Color.green : Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(width: 300, height: 200)
        .background(isCorrect ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
        .cornerRadius(12)
    }
}

// Preview provider for SwiftUI canvas
struct TimelineGameView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineGameView(
            eventData: ["Thời cơ Cách mạng tháng 8", "Tuyên Ngôn Độc Lập", "Vua Bảo Đại thoái vị", "Chính phủ kí sắc lệnh phát hành tiền Việt Nam"],
            periodData: ["15/8/1945", "2/9/1945", "30/8/1945", "31/1/1946"]
        )
    }
}
