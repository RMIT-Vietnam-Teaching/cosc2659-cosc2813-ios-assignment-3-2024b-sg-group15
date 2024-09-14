//
//  Book.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookView: View {
    @State private var currentChapterIndex: Int? = nil  // Use nil for the initial landing page
    @State private var currentPageIndex = 0
    @State private var flipStates: [[Bool]] = [
            [false, false, true], // Chapter 1: Page 2 cannot flip
            [true, true, true],  // Chapter 2: All pages can flip
            [true, false, true]  // Chapter 3: Page 2 cannot flip
        ]
    var body: some View {
        VStack {
//             Page Curl View Controller
            PageCurlViewController(
                chapters: [
                    [UIHostingController(rootView: OpenBookView())], // Use the updated LandingView
                    createChapter1(flipStates: $flipStates[0]),
                    createChapter2(flipStates: $flipStates[1]),
                    createChapter3(flipStates: $flipStates[2])
                ],
                currentChapterIndex: $currentChapterIndex,
                currentPageIndex: $currentPageIndex, flipStates: $flipStates
            )
            .edgesIgnoringSafeArea(.all)
            
            
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

    // Chapter creation helper methods using SimpleView instead of SimpleViewController
        func createChapter1(flipStates: Binding<[Bool]>) -> [UIViewController] {
            return [
                UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 1", backgroundColor: .red, flipState: flipStates[0])),
                UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 2", backgroundColor: .orange, flipState: flipStates[1])),
                UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 3", backgroundColor: .yellow, flipState: flipStates[2]))
            ]
        }

        func createChapter2(flipStates: Binding<[Bool]>) -> [UIViewController] {
            return [
                UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 1", backgroundColor: .green, flipState: flipStates[0])),
                UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 2", backgroundColor: .blue, flipState: flipStates[1])),
                UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 3", backgroundColor: .purple, flipState: flipStates[2]))
            ]
        }

        func createChapter3(flipStates: Binding<[Bool]>) -> [UIViewController] {
            return [
                UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 1", backgroundColor: .cyan, flipState: flipStates[0])),
                UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 2", backgroundColor: .blue, flipState: flipStates[1])),
                UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 3", backgroundColor: .brown, flipState: flipStates[2]))
            ]
        }
}

#Preview {
    BookView()
}
