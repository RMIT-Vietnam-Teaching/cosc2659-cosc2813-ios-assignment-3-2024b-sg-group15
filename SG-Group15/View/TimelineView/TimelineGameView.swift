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

struct TimelineGameView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var viewModel: TimelineGameViewModel
    @State private var showResultPopup = false
    @State private var showPopUp = false
    @State private var isSubmit = false
    
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
                
                VStack(spacing: 10) {
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
                .padding(.top, horizontalSizeClass == .compact ? 30 : 20)
                
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
                    print("kiem tra")
                        withAnimation {
                            
                            viewModel.checkAnswer()
                            isSubmit = true
                        }
                    }
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                    .position(x: width / 2, y: horizontalSizeClass == .compact ?  height / 4 : height - 50)
                }
                if isSubmit {
                    Button("Tiếp tục") {
                        goToNextPage()
//                        print("Next question")
                    }
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeButtonModifier(background: .redBrown)) : AnyViewModifier(LargeButtonModifierIpad(background: .redBrown)))
                    .position(x: width / 2, y: horizontalSizeClass == .compact ?  height / 4  : height / 4)
                }
            }
            .coordinateSpace(name: "gameArea")
        }
//        .padding(.vertical, 60)
        
    }
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}

