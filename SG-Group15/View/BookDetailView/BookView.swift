//
//  BookView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookView: View {
    @StateObject private var bookVM = BookViewModel()
    @State private var isOpen = false
    @State private var currentChapterIndex: Int? = 0 // Use nil for the initial landing page
    @State private var currentPageIndex = 0
    @State private var currentChapter: Int = 2
    
    
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
            if bookVM.isLoading {
                // Show a loading view while the data is being fetched
                ProgressView("Loading book data...")
                    .font(.largeTitle)
                    .padding()
            } else {
                if isOpen {
                    // Only show PageCurlViewController when data is ready
                    PageCurlViewController(
                        chapters: $bookVM.chapters,
                        coverPage: $coverPage,
                        currentChapterIndex: $currentChapterIndex,
                        currentPageIndex: $currentPageIndex
                    )
                    .edgesIgnoringSafeArea(.all)
                }
                else {
                    OpenBookView(isOpen: $isOpen, coverPage: $coverPage)
                }
            }}
        .onAppear {
            bookVM.fetchBook(bookID: "m9UkUeeRLMkcjqKB2eAr")
            currentChapterIndex = nil
            currentPageIndex = 0
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToChapter"))) { notification in
            if let chapter = notification.object as? Int {
                DispatchQueue.main.async {
                    currentChapterIndex = chapter
                    currentPageIndex = 0
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToNextPage"))) { _ in
                    moveToNextPage()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ExitBook"))) { _ in
            DispatchQueue.main.async {
                // Skip the cover and go back to the book detail view
                currentChapterIndex = 0
                currentPageIndex = 0 // Reset to the first page in the chapter
            }
        }
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
            let currentChapterPages = flipStates[chapterIndex - 1]
            
            // Check if there is another page in the current chapter
            if currentPageIndex < currentChapterPages.count - 1 {
                currentPageIndex += 1
            } else if chapterIndex - 1 < flipStates.count - 1 {
                // If no more pages in the current chapter, move to the next chapter
                currentChapterIndex = chapterIndex + 1
                currentPageIndex = 0
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
