//
//  ContentView.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentChapterIndex: Int? = nil  // Use nil for the initial landing page
    @State private var currentPageIndex = 0

    var body: some View {
        VStack {
            // Page Curl View Controller
            PageCurlViewController(
                chapters: [
                    [UIHostingController(rootView: OpenBookView())], // Use the updated LandingView
                    createChapter1(),
                    createChapter2(),
                    createChapter3()
                ],
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToMainPage"))) { _ in
            // Navigate back to the landing page when "Back" is pressed
            currentChapterIndex = nil
            currentPageIndex = 0
        }
    }

    // Chapter creation helper methods using SimpleView instead of SimpleViewController
    func createChapter1() -> [UIViewController] {
        return [
            UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 1", backgroundColor: .red)),
            UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 2", backgroundColor: .orange)),
            UIHostingController(rootView: SimpleView(text: "Chapter 1 - Page 3", backgroundColor: .yellow))
        ]
    }

    func createChapter2() -> [UIViewController] {
        return [
            UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 1", backgroundColor: .green)),
            UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 2", backgroundColor: .blue)),
            UIHostingController(rootView: SimpleView(text: "Chapter 2 - Page 3", backgroundColor: .purple))
        ]
    }

    func createChapter3() -> [UIViewController] {
        return [
            UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 1", backgroundColor: .cyan)),
            UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 2", backgroundColor: .blue)),
            UIHostingController(rootView: SimpleView(text: "Chapter 3 - Page 3", backgroundColor: .brown))
        ]
    }
}
#Preview {
    ContentView()
}
