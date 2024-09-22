//
//  ResultView.swift
//  SG-Group15
//
//  Created by Do Le Long An on 21/9/24.
//

import Foundation
import SwiftUI

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
