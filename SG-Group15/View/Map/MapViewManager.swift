// MapViewManager.swift
import SwiftUI
struct MapViewManager: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text(viewModel.question)
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

struct MapViewManager_Previews: PreviewProvider {
    static var previews: some View {
        let exampleViewModel = MapViewModel(
            question: "Chủ tịch Hồ Chí Minh chọn đâu làm căn cứ chỉ đạo Cách Mạng?",
            mapChoices: ["Bình Yên", "Tân Trào", "Trung Yên", "Minh Thanh", "Lương Thiện"],
            correctAnswer: "Tân Trào"
        )
        let exampleViewModel2 = MapViewModel(
            question: "Hội nghị ban chấp hành Trung Ương Đảng họp tại đâu?",
            mapChoices: ["Bà Điểm", "Xuân Thới Thượng", "Tân Xuân", "Xuân Thới Sơn"],
            correctAnswer: "Bà Điểm"
        )
        MapViewManager(viewModel: exampleViewModel2)
            .previewLayout(.sizeThatFits)
    }
}
