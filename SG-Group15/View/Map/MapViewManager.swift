// MapViewManager.swift
import SwiftUI
struct MapViewManager: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("\(viewModel.mapQuestion)")
                    .font(.headline)
                    .padding()
                Spacer()
                // Feedback after selection
                if let selected = viewModel.selectedAnswer {
                    if selected == viewModel.correctAnswer {
                        Text("Correct!")
                            .foregroundColor(.green)
                            .font(.title2)
                            .padding()
                    } else {
                        Text("Wrong! Correct Answer: \(viewModel.correctAnswer)")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
            }
            
            if viewModel.mapType != nil, let mapData = viewModel.mapData {
                MapComponent(
                    viewModel: viewModel,
                    mapImage: mapData.mapImage,
                    mapPoints: mapData.mapPoints,
                    correctAnswer: mapData.correctAnswer,
                    config: mapData.config
                )
            } else {
                Text("Invalid Map Type")
                    .foregroundColor(.red)
            }
           
        }

    }
}
