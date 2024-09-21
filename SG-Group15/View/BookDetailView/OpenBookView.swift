//
//  OpenBookView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct OpenBookView: View {
//    @State private var isOpen = false
    @Binding var isOpen: Bool
    @State private var isScaled = false
    @State private var showCover = true
    @Binding var coverPage: CoverPage
    
    var body: some View {
        ZStack {
//            Color("beigeBackground")
//                .ignoresSafeArea()
//            
            // Page (visible after the book opens)
            if isOpen {
                BookDetailView(page: $coverPage)

                    .padding(0)
            }

            if showCover {
                // The book cover (shown initially, then rotates open and disappears)
                CoverPageView(isScaled: $isScaled, isOpen: $isOpen, showCover: $showCover)
                
            }
        }

        .onAppear {
            if isOpen {
                showCover = false
            }
        }
        .onChange(of: isOpen) {old ,new in
            if new {
                showCover = false
            }
        }

    }
}
