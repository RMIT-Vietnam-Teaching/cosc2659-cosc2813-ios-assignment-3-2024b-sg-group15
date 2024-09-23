//
//  Book.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var bookVM: BookViewModel
    var bookID: String
    @Binding var isOpen: Bool
    @State private var currentChapterIndex: Int = 1 // Use nil for the initial landing page
    @State private var currentPageIndex = 0
    @State private var flipStates: [[Bool]] = [
            [true, false, false], // Chapter 1: Page 2 cannot flip
            [false, false, false],  // Chapter 2: All pages can flip
            [false, false, false]  // Chapter 3: Page 2 cannot flip
        ]
    
    
//    @State var coverPage = CoverPage(title: "CÁCH MẠNG THÁNG 8 - 1945", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
    
    var body: some View {
        VStack {
            if bookVM.isLoading {
                // Show a loading view while the data is being fetched
                ProgressView("Đang tải...")
                    .font(.largeTitle)
                    .padding()
            } else {
                if isOpen {
                    VStack {
                        if currentPageIndex == 0 {
//                            Button("close") {
//                                isOpen = false
//                                print(isOpen)
//                            }

                            Button(action: {
//                                dismiss()
                                isOpen = false
                            }) {
                                Text("close")
                                Image(systemName: "arrow.backward")
                                    .resizable()
                                    .frame(width: horizontalSizeClass == .compact ? 15 : 30, height: horizontalSizeClass == .compact ? 15 : 30)
//                                    .modifier(BodyTextModifier(color: Color.darkGreen))
                            }
                            .background(.clear)
                            .offset(y: 100)
                        }
                        
                        // Only show PageCurlViewController when data is ready
                        PageCurlViewController(
                            chapters: $bookVM.chapters,
                            currentChapterIndex: $currentChapterIndex,
                            currentPageIndex: $currentPageIndex
                        )
                        .edgesIgnoringSafeArea(.all)
                        
                        
                        
                    }
                }
                else {
                    OpenBookView(isOpen: $isOpen, bookVM: bookVM, chapterNum: $currentChapterIndex)
                }
            }
        }
        .onAppear {
            bookVM.fetchBook(bookID: bookID)
            currentChapterIndex = 1
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
