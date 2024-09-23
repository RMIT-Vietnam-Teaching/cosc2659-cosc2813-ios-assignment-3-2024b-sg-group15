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


struct CoverPageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @Binding var isScaled: Bool
    @Binding var isOpen: Bool
    @Binding var showCover: Bool
    var bookID: String
    
    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .global)
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            let progress = (minX) / rect.width
            let rotation = progress * 25
            
            ZStack {
                Color.beigeBackground
                    .ignoresSafeArea()
                Group {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("primaryRed"))
                        .padding(.horizontal, horizontalSizeClass == .compact ? 30 : 70)
                        .padding(.vertical, isScaled ? 0 : 150)
                        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 5, y: 5) // Adding shadow
                        .rotation3DEffect(
                            .init(degrees: rotation), axis: (x: 0, y: 0.5, z: 0), anchor: .leading, perspective: 1)
                    
                    VStack(spacing: 60) {
                        if bookID == "m9UkUeeRLMkcjqKB2eAr" {
                            Text("Cách mạng tháng 8 - 1945")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad())).padding(.horizontal, horizontalSizeClass == .compact ? 40 : 100)
                                .multilineTextAlignment(.center)
                        }
                        else {
                            Text("Chiến dịch Điện Biên Phủ - 1954")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad())).padding(.horizontal, horizontalSizeClass == .compact ? 40 : 100)
                                .multilineTextAlignment(.center)
                        }
                        
                        Image("cover")
                            .resizable()
                            .frame(width: horizontalSizeClass == .compact ? 150 : 400, height: horizontalSizeClass == .compact ? 150 : 400)
                            
                    }
                }
                .rotation3DEffect(
                    .degrees(isOpen ? -180 : 0), // Rotate to simulate opening
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .leading
                )
                .scaleEffect(isScaled ? 1.0 : 0.6)
                .animation(.easeIn(duration: 1.5), value: isScaled)
                .onTapGesture {
                    withAnimation {
                        isScaled.toggle() // Scale up the book
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            isOpen = true // Open the book after scaling
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        withAnimation {
                            showCover = false // Hide the cover after opening
                            isScaled = false
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
////    CoverPageView(isScaled: .constant(true), isOpen: .constant(false), showCover: .constant(true))
//    BookView()
//}
