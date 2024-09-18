//
//  BookView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookView: View {
    @State private var currentChapterIndex: Int? = nil  // Use nil for the initial landing page
    @State private var currentPageIndex = 0
    @State private var currentChapter: Int = 2
    
    @State private var chapters: [Chapter] = [
        Chapter(pages: [Page(content: "Landing Page", canFlip: true)]),
           Chapter(pages: [
               Page(content: "Chapter 1 - Page 1", canFlip: true),
               Page(content: "Chapter 1 - Page 2", canFlip: false),
               Page(content: "Chapter 1 - Page 3", canFlip: true)
           ]),
           Chapter(pages: [
               Page(content: "Chapter 2 - Page 1", canFlip: true),
               Page(content: "Chapter 2 - Page 2", canFlip: true),
               Page(content: "Chapter 2 - Page 3", canFlip: true)
           ]),
           Chapter(pages: [
               Page(content: "Chapter 3 - Page 1", canFlip: true),
               Page(content: "Chapter 3 - Page 2", canFlip: false),
               Page(content: "Chapter 3 - Page 3", canFlip: true)
           ])
       ]
    
    @State var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
    
    var body: some View {
        VStack {
            PageCurlViewController(
                chapters: chapters, coverPage: $coverPage,
                       currentChapterIndex: $currentChapterIndex,
                       currentPageIndex: $currentPageIndex
                   )
            .edgesIgnoringSafeArea(.all)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToChapter"))) { notification in
            if let chapter = notification.object as? Int {
                currentChapterIndex = chapter  // Offset because the landing page is the first element
                currentPageIndex = 0
            }
        }
//        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToMainPage"))) { _ in
//            // This will trigger the goToMainPage method in the coordinator
//        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToNextPage"))) { _ in
                    moveToNextPage()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToCurrentChapter"))) { _ in
            moveToCurrentChapter()
        }
    }
    
    private func moveToCurrentChapter() {
        currentChapterIndex = currentChapter
    }
    
    private func moveToNextPage() {
        if let chapterIndex = currentChapterIndex {
            let currentChapter = chapters[chapterIndex]
            let currentPage = currentChapter.pages[currentPageIndex]

            // Check if the current page can be flipped
            if currentPage.canFlip {
                // Check if there's another page in the current chapter
                if currentPageIndex < currentChapter.pages.count - 1 {
                    // Move to the next page in the current chapter
                    currentPageIndex += 1
                } else if chapterIndex < chapters.count - 1 {
                    // If no more pages in the current chapter, move to the next chapter
                    currentChapterIndex = chapterIndex + 1
                    currentPageIndex = 0
                } else {
                    print("No more chapters available.")
                }
            } else {
                print("Cannot flip this page.")
            }
        } else {
            // Handle the case when currentChapterIndex is nil (e.g., the landing page)
            currentChapterIndex = 0 // Move to the first chapter
            currentPageIndex = 0
        }
     }
}

#Preview {
    BookView()
}
