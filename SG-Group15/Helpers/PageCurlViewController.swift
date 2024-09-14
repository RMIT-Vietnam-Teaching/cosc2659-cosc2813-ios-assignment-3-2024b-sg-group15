//
//  PageCurlViewController.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI
import UIKit

struct PageCurlViewController: UIViewControllerRepresentable {
    var chapters: [[UIViewController]] // Chapters containing pages (including landing page)
    @Binding var currentChapterIndex: Int?
    @Binding var currentPageIndex: Int
    @Binding var flipStates: [[Bool]]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        // Initially show the landing page
        if let chapterIndex = currentChapterIndex {
            pageViewController.setViewControllers(
                [chapters[chapterIndex][currentPageIndex]],
                direction: .forward,
                animated: true,
                completion: nil
            )
        } else {
            pageViewController.setViewControllers(
                [chapters[0][0]], // Landing page
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        if let chapterIndex = currentChapterIndex {
            let currentChapterPages = chapters[chapterIndex]

            if currentViewController != currentChapterPages[currentPageIndex] {
                let direction: UIPageViewController.NavigationDirection = .forward
                pageViewController.setViewControllers(
                    [currentChapterPages[currentPageIndex]],
                    direction: direction,
                    animated: true,
                    completion: nil
                )
            }
        } else {
            pageViewController.setViewControllers(
                [chapters[0][0]], // Landing page
                direction: .reverse,
                animated: true,
                completion: nil
            )
        }
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageCurlViewController

        init(_ pageCurlViewController: PageCurlViewController) {
            self.parent = pageCurlViewController
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            if let chapterIndex = parent.currentChapterIndex {
                let chapter = parent.chapters[chapterIndex]
                if let pageIndex = chapter.firstIndex(of: viewController), pageIndex > 0 {
                    return chapter[pageIndex - 1]
                } else if chapterIndex > 0 {
                    return parent.chapters[chapterIndex - 1].last
                }
            }
            return nil
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex
//
//            // Prevent flipping if the current page cannot flip
//            if !parent.flipStates[chapterIndex][pageIndex] {
                print("Chapter : \(chapterIndex) + Page Index: \(pageIndex)")
//                return nil
//            }
            
            if let chapterIndex = parent.currentChapterIndex {
                let chapter = parent.chapters[chapterIndex]
                if let pageIndex = chapter.firstIndex(of: viewController), pageIndex < chapter.count - 1 {
                    return chapter[pageIndex + 1]
                } else if chapterIndex < parent.chapters.count - 1 {
                    return parent.chapters[chapterIndex + 1].first
                }
            }
            return nil
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first {
                for (chapterIndex, chapter) in parent.chapters.enumerated() {
                    if let pageIndex = chapter.firstIndex(of: visibleViewController) {
                        parent.currentChapterIndex = chapterIndex
                        parent.currentPageIndex = pageIndex
                        break
                    }
                }
            }
        }
    }
}
