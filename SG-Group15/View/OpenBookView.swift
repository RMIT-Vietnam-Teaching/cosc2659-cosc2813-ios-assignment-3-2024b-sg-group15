//
//  OpenBookView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI


struct OpenBookView: View {
    @State private var isOpen = false
    @State private var isScaled = false
    @State private var showCover = true

    var body: some View {
        ZStack {
            // Page (visible after the book opens)
            if isOpen {
                    BookDetailViewIphone()
                    .background(Color("bg-color"))
//                    .scaledToFit()
                    .padding(0)
            }

            if showCover {
                // The book cover (shown initially, then rotates open and disappears)
                ZStack {
                    Color.blue
//                        .frame(width: 200, height: 300)
                        .cornerRadius(5)
                        .shadow(radius: 10)
                    
                    Text("Book Title")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                }
                .rotation3DEffect(
                    .degrees(isOpen ? -180 : 0), // Rotate to simulate opening
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .leading
                )
                .scaleEffect(isScaled ? 1 : 0.5) // Scale the book cover up
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            showCover = false // Hide the cover after opening
                        }
                    }
                }
            }

            // Book Spine
//            if !isOpen {
//                Rectangle()
//                    .fill(Color.gray)
//                    .frame(width: 10, height: 300)
//                    .offset(x: -105) // Positioning for the spine
//            }
        }
//        .frame(width: 300, height: 400)
    }
}

#Preview {
    OpenBookView()
}
