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

struct BookView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var bookVM: BookViewModel
    var bookID: String
    @Binding var isOpen: Bool
    @State private var currentChapterIndex: Int = 0
    @State private var currentPageIndex = 0
    @State private var flipStates: [[Bool]] = [
            [true, false, false], // Chapter 1: Page 2 cannot flip
            [false, false, false],  // Chapter 2: All pages can flip
            [false, false, false]  // Chapter 3: Page 2 cannot flip
        ]
    
    
    var body: some View {
        VStack {
            if bookVM.isLoading {
                // Show a loading view while the data is being fetched
               LoadingView()
            } else {
                if isOpen {
                    ZStack {
                        // Only show PageCurlViewController when data is ready
                        PageCurlViewController(
                            chapters: $bookVM.chapters,
                            currentChapterIndex: $currentChapterIndex,
                            currentPageIndex: $currentPageIndex
                        )
                        .edgesIgnoringSafeArea(.all)
                        
                        if currentPageIndex == 0 {
                            Button(action: {
                                isOpen.toggle()
                                print(isOpen)
                            }, label: {
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            })
                            .offset(x: horizontalSizeClass == .compact ? -140 : -300, y: horizontalSizeClass == .compact ? -320 : -440)
                        }
                        
                    }
                }
                else {
                    OpenBookView(isOpen: $isOpen, bookVM: bookVM, chapterNum: $currentChapterIndex, bookID: bookID)
                }
            }
        }
        .onAppear {
            bookVM.fetchBook(bookID: bookID)
            currentChapterIndex = 0
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToMainPage"))) { _ in
            DispatchQueue.main.async {
                // Navigate back to the landing page when "Back" is pressed
                currentChapterIndex = 0
                currentPageIndex = 0
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
//        if let chapterIndex = currentChapterIndex {
            let currentChapterPages = flipStates[currentChapterIndex - 1]
            
            // Check if there is another page in the current chapter
            if currentPageIndex < currentChapterPages.count - 1 {
                currentPageIndex += 1
            } else if currentChapterIndex - 1 < flipStates.count - 1 {
                // If no more pages in the current chapter, move to the next chapter
                currentChapterIndex = currentChapterIndex + 1
                currentPageIndex = 0
            } else {
                print("No more chapters available.")
            }
//        }
    }
}

#Preview {
    BookView(bookVM: BookViewModel(), bookID: "QuloSOsGc5FLGbW80bR7", isOpen: .constant(true))
}
