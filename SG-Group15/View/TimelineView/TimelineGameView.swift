//
//  TimelineGameView.swift
//  SG-Group15
//
//  Created by Do Le Long An on 18/9/24.
//

import Foundation
import SwiftUI

struct TimelineGameView: View {
    @StateObject private var viewModel = TimelineGameViewModel()
    @State private var showResultPopup = false
    
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
            }
            .coordinateSpace(name: "gameArea")
            .onAppear {
                viewModel.fetchQuestion(from: "CuOIjLZ0nQRmAWs53mcJ")
            }
        }
       
    }
}


// Preview provider for SwiftUI canvas
struct TimelineGameView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineGameView()
    }
}
