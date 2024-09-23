//
//  OpenBookView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct OpenBookView: View {
    @Binding var isOpen: Bool
    @State private var isScaled = false
    @State private var showCover = true
    @ObservedObject var bookVM: BookViewModel
    @Binding var chapterNum: Int
    
    var body: some View {
        ZStack {
            // Page (visible after the book opens)
            if isOpen {
                BookDetailView(title: bookVM.chapters[chapterNum].title, description: bookVM.chapters[chapterNum].description)
                    .padding(0)
            } else {
               CoverPageView(isScaled: $isScaled, isOpen: $isOpen, showCover: $showCover)

            }
//        }
//
//            if showCover {
//                // The book cover (shown initially, then rotates open and disappears)
//                CoverPageView(isScaled: $isScaled, isOpen: $isOpen, showCover: $showCover)
//                
//            }
        }
        .onAppear {
            if isOpen {
                showCover = false
            } else {
                showCover = true
            }
        }
//              .onChange(of: isOpen) {old ,new in
//                  if new {
//                      showCover = false
//                  }
//              }
        
    }
}

