//
//  CoverPageView.swift
//  SG-Group15
//
//  Created by Nana on 14/9/24.
//

import SwiftUI

struct CoverPageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @Binding var isScaled: Bool
    @Binding var isOpen: Bool
    @Binding var showCover: Bool

    @State private var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "CÁCH MẠNG THÁNG 8 - 1945")
    
    var body: some View {
<<<<<<< HEAD
        GeometryReader {
            let rect = $0.frame(in: .global)
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            let progress = (minX) / rect.width
            let rotation = progress * 25
            
            ZStack {
                
                Group {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("primaryRed"))
                        .padding(.horizontal, horizontalSizeClass == .compact ? 30 : 70)
                        .padding(.vertical, isScaled ? 0 : 150)
                        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 5, y: 5) // Adding shadow
                        .rotation3DEffect(
                            .init(degrees: rotation), axis: (x: 0, y: 0.5, z: 0), anchor: .leading, perspective: 1)
                    
                    VStack(spacing: 60) {
                        Text("CÁCH MẠNG THÁNG 8 - 1945")
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad())).padding(.horizontal, horizontalSizeClass == .compact ? 40 : 100)
                            .multilineTextAlignment(.center)
                        
                        Image("cover")
                            .resizable()
                            .frame(width: horizontalSizeClass == .compact ? 150 : 400, height: horizontalSizeClass == .compact ? 150 : 400)
>>>>>>> data-model
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
                        }
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
