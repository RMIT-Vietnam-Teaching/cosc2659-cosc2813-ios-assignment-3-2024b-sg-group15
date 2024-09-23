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
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                    .padding()
                
                Spacer()
                // Feedback after selection
                if let selected = viewModel.selectedAnswer {
                    if selected == viewModel.correctAnswer {
                        Text("Correct!")
                            .foregroundColor(.green)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title3TextModifier()) : AnyViewModifier(Title3TextModifierIpad()))                   .padding()
                    } else {
                        Text("Wrong! Correct Answer: \(viewModel.correctAnswer)")
                            .foregroundColor(.red)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title3TextModifier()) : AnyViewModifier(Title3TextModifierIpad()))
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
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title3TextModifier()) : AnyViewModifier(Title3TextModifierIpad())) 
            }
        }
    }
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}
