//
//  PageCurlViewController.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI
import UIKit

struct PageCurlViewController: UIViewControllerRepresentable {
    var chapters: [Chapter]
    @Binding var coverPage: CoverPage
    @Binding var currentChapterIndex: Int?
    @Binding var currentPageIndex: Int

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil
        )

        // Set the initial page
        if let chapterIndex = currentChapterIndex {
            pageViewController.setViewControllers(
                [context.coordinator.createHostingController(for: currentPageIndex, in: chapterIndex)],
                direction: .forward,
                animated: true,
                completion: nil
            )
        } else {
            pageViewController.setViewControllers(
                [context.coordinator.createHostingController(for: 0, in: 0)],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }

        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        // Store the pageViewController reference in the coordinator
        context.coordinator.pageViewController = pageViewController

        // Observe the "GoToNextPage" notification for programmatic page flip
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.goToNextPage), name: NSNotification.Name("GoToNextPage"), object: nil)

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        guard let chapterIndex = currentChapterIndex else { return }
        let currentViewController = context.coordinator.createHostingController(for: currentPageIndex, in: chapterIndex)

        // Ensure the correct page is shown
        pageViewController.setViewControllers(
            [currentViewController],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageCurlViewController
        var pageViewController: UIPageViewController?

        init(_ pageCurlViewController: PageCurlViewController) {
            self.parent = pageCurlViewController
        }

        func createHostingController(for pageIndex: Int, in chapterIndex: Int) -> UIViewController {
            // Check if it's the landing page
            if chapterIndex == 0 {
                return UIHostingController(rootView: OpenBookView(coverPage: parent.$coverPage))
            } else {
                let page = self.parent.chapters[chapterIndex].pages[pageIndex]
                return UIHostingController(rootView: SimpleView(page: page))
            }
        }

        // Handle the "Next Page" button press notification
        @objc func goToNextPage() {
            guard let pageViewController = pageViewController else { return }
            guard let currentVC = pageViewController.viewControllers?.first else { return }

            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex

            // Check if the current page can flip
            if !parent.chapters[chapterIndex].pages[pageIndex].canFlip {
                print("Cannot flip to the next page.")
                return
            }

            // Find the next view controller
            if let nextViewController = self.pageViewController(pageViewController, viewControllerAfter: currentVC) {
                if parent.currentPageIndex < parent.chapters[chapterIndex].pages.count - 1 {
                    parent.currentPageIndex += 1
                } else if chapterIndex < parent.chapters.count - 1 {
                    parent.currentChapterIndex = chapterIndex + 1
                    parent.currentPageIndex = 0
                }
                pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            }
        }

        // Handle swipe to the previous page
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex

            // Prevent flipping if the current page cannot flip
            if !parent.chapters[chapterIndex].pages[pageIndex].canFlip {
                return nil
            }

            if pageIndex > 0 {
                parent.currentPageIndex = pageIndex - 1
                return createHostingController(for: parent.currentPageIndex, in: chapterIndex)
            } else if chapterIndex > 0 {
                parent.currentChapterIndex = chapterIndex - 1
                parent.currentPageIndex = parent.chapters[chapterIndex - 1].pages.count - 1
                return createHostingController(for: parent.currentPageIndex, in: parent.currentChapterIndex!)
            }
            return nil
        }

        // Handle swipe to the next page
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex

            // Prevent flipping if the current page cannot flip
            if !parent.chapters[chapterIndex].pages[pageIndex].canFlip {
                return nil
            }

            if pageIndex < parent.chapters[chapterIndex].pages.count - 1 {
                parent.currentPageIndex = pageIndex + 1
                return createHostingController(for: parent.currentPageIndex, in: chapterIndex)
            } else if chapterIndex < parent.chapters.count - 1 {
                parent.currentChapterIndex = chapterIndex + 1
                parent.currentPageIndex = 0
                return createHostingController(for: parent.currentPageIndex, in: parent.currentChapterIndex!)
            }
            return nil
        }

        // Update the current chapter and page after a swipe transition
        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first as? UIHostingController<SimpleView> {
                if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].pages.firstIndex(where: { $0.id == visibleViewController.rootView.page.id }) {
                    parent.currentPageIndex = pageIndex
                }
            }
        }
    }
}
