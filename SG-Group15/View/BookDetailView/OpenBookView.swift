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
    @Binding var coverPage: CoverPage
    
    var body: some View {
        ZStack {
//            Color("beigeBackground")
//                .ignoresSafeArea()
//            
            // Page (visible after the book opens)
            if isOpen {
                BookDetailView(page: $coverPage)
//                    .scaledToFit()
                    .padding(0)
            }

            if showCover {
                // The book cover (shown initially, then rotates open and disappears)
                CoverPageView(isScaled: $isScaled, isOpen: $isOpen, showCover: $showCover)
                
            }
        }
        
    }
}

#Preview {
    OpenBookView(coverPage: .constant(CoverPage(title: "123", content: "123")))
}
