import SwiftUI

struct TimelineGameView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @StateObject private var viewModel: TimelineGameViewModel
    let eventData: [String]
    let periodData: [String]
    @State private var showResultPopup = false
    @State private var showPopUp = false
    @State private var isSubmit = false

    init(eventData: [String], periodData: [String]) {
        self.eventData = eventData
        self.periodData = periodData
        _viewModel = StateObject(wrappedValue: TimelineGameViewModel(eventData: eventData, periodData: periodData))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let eventWidth = min(width * 0.33, 230)
            let eventHeight = min(height * 0.1, 200)
            let periodWidth = eventWidth
            let periodHeight = eventHeight

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
                    
                    Text("Kéo các sự kiện sau đây ứng với mốc thời gian")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(QuestionTextModifier()) : AnyViewModifier(QuestionTextModifierIpad()))
                        .padding(5)
                    
                    ZStack {
                        if !isSubmit {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: width * 0.02),
                                GridItem(.flexible(), spacing: width * 0.02)
                            ],
                            spacing: width * 0.05 ) {
                                ForEach(viewModel.events.indices, id: \.self) { index in
                                    Color.clear
                                        .frame(width: eventWidth, height: eventHeight)
                                        .background(
                                            GeometryReader { geo in
                                                Color.clear
                                                    .onAppear {
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
                            .padding(.horizontal, horizontalSizeClass == .compact ? width * 0.1 : width * 0.16)
                        } else {
                            ResultView(viewModel: viewModel)
                        }
                    }
                    .frame(height: 2 * eventHeight + 1.6 * (width * 0.05)) // Height for 4 rows of events + 3 spacings
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.darkRed)
                            .frame(width: 5, height: height * 0.5)
                        VStack(spacing: height * 0.03) {
                            ForEach(viewModel.timePeriods.indices, id: \.self) { index in
                                TimePeriodView(period: $viewModel.timePeriods[index], width: periodWidth, height: periodHeight, isEven: index % 2 == 0, screenWidth: width)
                            }
                        }
                        .padding()
                    }
                }
                .padding(.horizontal, horizontalSizeClass == .compact ? 0 : 20)
                .padding(.top, horizontalSizeClass == .compact ? 0 : 20)

                ForEach($viewModel.events) { $event in
                    EventView(viewModel: viewModel, event: event, width: eventWidth, height: eventHeight)
                        .position(event.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if !viewModel.isSubmitted {
                                            event.position = value.location
                                        }
                                }
                                .onEnded { value in
                                    if !viewModel.isSubmitted {
                                        
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
                                }
                        )
                }
                
                if viewModel.isGameComplete && !viewModel.isSubmitted {
                    Button("Kiểm tra") {
                        withAnimation {
                            isSubmit = true
                            viewModel.checkAnswer()
                        }
                    }
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                    .position(x: width / 2, y: horizontalSizeClass == .compact ?  height - 10 : height - 50)
                }
                if isSubmit {
                    Button("Tiếp tục") {
                        print("Next question")
                    }
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                    .position(x: width / 2, y: horizontalSizeClass == .compact ?  height - 10 : height - 50)
                }
            }
            .coordinateSpace(name: "gameArea")
        }
    }
}

struct ResultView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel: TimelineGameViewModel

    var body: some View {
        VStack(spacing: 20) {
            if incorrectPlacements.isEmpty {
                Text("")
                    .font(.headline)
                    .foregroundColor(.green)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(incorrectPlacements, id: \.period.id) { placement in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                        Text("\(placement.period.period) - \(getEventLetter(placement.correctEvent.name))")
                                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                                    }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private var incorrectPlacements: [(period: TimePeriod, incorrectEvent: TimelineEvent, correctEvent: TimelineEvent)] {
        viewModel.timePeriods.compactMap { period in
            if let placedEvent = viewModel.events.first(where: { $0.currentPeriod == period.id }),
               let correctEvent = viewModel.events.first(where: { $0.id == period.id }),
               placedEvent.id != correctEvent.id {
                return (period: period, incorrectEvent: placedEvent, correctEvent: correctEvent)
            }
            return nil
        }
    }
    private func getEventLetter(_ eventName: String) -> String {
           // Extract the letter from the event name (assuming it's always at the beginning)
           return String(eventName.prefix(1))
       }
}

// Preview provider for SwiftUI canvas
struct TimelineGameView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineGameView(
            eventData: ["A. Thời cơ Cách mạng tháng 8", "B. Tuyên Ngôn Độc Lập", "C. Vua Bảo Đại thoái vị", "D. Chính phủ kí sắc lệnh phát hành tiền Việt Nam"],
            periodData: ["15/8/1945", "2/9/1945", "30/8/1945", "31/1/1946"]
        )
    }
}
