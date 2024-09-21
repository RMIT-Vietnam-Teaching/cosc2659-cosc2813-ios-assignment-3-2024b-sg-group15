//
//  Book.swift
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
    @State private var flipStates: [[Bool]] = [
            [true, false, false], // Chapter 1: Page 2 cannot flip
            [false, false, false],  // Chapter 2: All pages can flip
            [false, false, false]  // Chapter 3: Page 2 cannot flip
        ]
    
    
    @State var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
    
    var body: some View {
        VStack {
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
