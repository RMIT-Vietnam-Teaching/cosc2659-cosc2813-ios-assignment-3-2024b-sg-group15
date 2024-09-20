//
//  Book.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookView: View {
    @StateObject private var bookVM = BookViewModel()
    @State private var currentChapterIndex: Int? = nil  // Use nil for the initial landing page
    @State private var currentPageIndex = 0
    @State private var flipStates: [[Bool]] = [
            [true, false, false], // Chapter 1: Page 2 cannot flip
            [false, false, false],  // Chapter 2: All pages can flip
            [false, false, false]  // Chapter 3: Page 2 cannot flip
        ]
    
  
    
    @State var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
    
    var body: some View {
        VStack {
            PageCurlViewController(
                chapters: bookVM.chapters, coverPage: $coverPage,
                       currentChapterIndex: $currentChapterIndex,
                       currentPageIndex: $currentPageIndex
                   )
            .edgesIgnoringSafeArea(.all)
            
            
        }
        .onAppear {
            bookVM.fetchBook(bookID: "m9UkUeeRLMkcjqKB2eAr")
            print(bookVM.chapters.count)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToChapter"))) { notification in
            if let chapter = notification.object as? Int {
                currentChapterIndex = chapter  // Offset because the landing page is the first element
                currentPageIndex = 0
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToMainPage"))) { _ in
            // Navigate back to the landing page when "Back" is pressed
            currentChapterIndex = nil
            currentPageIndex = 0
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToNextPage"))) { _ in
                    moveToNextPage()
        }
    }
    
    private func moveToNextPage() {
        if let chapterIndex = currentChapterIndex {
//            print(chapterIndex)
            let currentChapterPages = flipStates[chapterIndex - 1]
            
            // Check if there is another page in the current chapter
            if currentPageIndex < currentChapterPages.count - 1 {
                currentPageIndex += 1
            } else if chapterIndex - 1 < flipStates.count - 1 {
                // If no more pages in the current chapter, move to the next chapter
                currentChapterIndex = chapterIndex + 1
                currentPageIndex = 0
            } else {
                print("No more chapters available.")
            }
        }
    }
}

#Preview {
    BookView()
}
