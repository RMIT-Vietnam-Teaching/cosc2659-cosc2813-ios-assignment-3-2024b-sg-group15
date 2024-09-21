//
//  CoverPageView.swift
//  SG-Group15
//
//  Created by Nana on 14/9/24.
//

import SwiftUI

struct CoverPageView: View {
    @Binding var isScaled: Bool
    @Binding var isOpen: Bool
    @Binding var showCover: Bool

    @State private var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "CÁCH MẠNG THÁNG 8 - 1945")
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("primaryRed"))
                    .padding(.horizontal, 30)
                    .padding(.vertical, isScaled ? 80 : 150)
                    .shadow(color: Color.black.opacity(0.8), radius: 5, x: 5, y: 5) // Adding shadow
                
                VStack(spacing: 60) {
                    Text("CÁCH MẠNG THÁNG 8 - 1945")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Image("cover")
                        .resizable()
                        .frame(width: isScaled ? 170 : 170, height: isScaled ? 170 : 170)
                }
            }
            .rotation3DEffect(
                .degrees(isOpen ? -180 : 0), // Rotate to simulate opening
                axis: (x: 0, y: 1, z: 0),
                anchor: .leading
            )
            .scaleEffect(isScaled ? 1.0 : 0.6)
            .animation(.easeIn(duration: 1.0), value: isScaled)
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
                    }
                }
            }
        }
    }
}

#Preview {
//    CoverPageView(isScaled: .constant(true), isOpen: .constant(false), showCover: .constant(true))
    BookView()
}
