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

struct OpenBookView: View {
    @Binding var isOpen: Bool
    @State private var isScaled = false
    @State private var showCover = true
    @ObservedObject var bookVM: BookViewModel
    @Binding var chapterNum: Int
    var bookID: String
    
    
    var body: some View {
        ZStack {
            // Page (visible after the book opens)
            if isOpen {
                BookDetailView(title: bookVM.chapters[chapterNum].title, description: bookVM.chapters[chapterNum].description)
                    .padding(0)
            } else {
               CoverPageView(isScaled: $isScaled, isOpen: $isOpen, showCover: $showCover, bookID: bookID)

            }
        }
        .onAppear {
            if isOpen {
                showCover = false
            } else {
                showCover = true
            }
        }
        
    }
}

