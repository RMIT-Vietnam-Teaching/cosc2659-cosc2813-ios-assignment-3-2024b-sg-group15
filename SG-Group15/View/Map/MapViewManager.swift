// MapViewManager.swift
import SwiftUI
struct MapViewManager: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
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
            .padding(.top, 60)
            .padding(.bottom, 40)
            
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
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}
