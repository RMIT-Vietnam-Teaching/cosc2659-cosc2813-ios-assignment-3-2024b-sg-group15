//
//  LandingView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI


struct LandingView: View {
    @State private var isScaled = false  // Controls the scaling effect
    @State private var selectedChapter: Int? = nil // To handle the selected chapter after animation
    @State private var shouldFlip = false // Controls the flip after scaling

    var body: some View {
        VStack(spacing: 40) {
            // Title
            Text("Welcome to the Book")
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            // Chapter buttons
            VStack(spacing: 20) {
                Button(action: {
                    startAnimationAndGoToChapter(0)
                }) {
                    Text("Go to Chapter 1")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    startAnimationAndGoToChapter(1)
                }) {
                    Text("Go to Chapter 2")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    startAnimationAndGoToChapter(2)
                }) {
                    Text("Go to Chapter 3")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink.edgesIgnoringSafeArea(.all))
        .scaleEffect(isScaled ? 1.0 : 0.6) // Initially small
        .animation(.easeInOut(duration: 0.5), value: isScaled) // Scale up animation
        .onChange(of: isScaled) { newValue in
            if newValue, let chapter = selectedChapter {
                // Once scaled up, trigger a slight delay before flipping
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    NotificationCenter.default.post(name: NSNotification.Name("GoToChapter"), object: chapter)
                }
            }
        }
        .onDisappear {
            withAnimation {
                isScaled = false
            }
        }
    }

    // Handle animation and navigate after the scale animation completes
    func startAnimationAndGoToChapter(_ chapterIndex: Int) {
        selectedChapter = chapterIndex
        isScaled = true // Trigger the scaling animation
    }
}

#Preview {
    LandingView()
}
