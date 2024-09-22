//
//  PageCurlViewController.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI
import UIKit

struct ChapterWithQuestionVM {
    var id: String
    var questionVMs: [QuestionViewModel]
    
}

struct PageCurlViewController: UIViewControllerRepresentable {
    @Binding var chapters: [Chapter]
    @Binding var coverPage: CoverPage
    @Binding var currentChapterIndex: Int?
    @Binding var currentPageIndex: Int
    @State private var canFlip = true
    
    // Store converted ChapterWithQuestionVM list
    private var chaptersWithQuestionVMs: [ChapterWithQuestionVM]=[]
    
    init(chapters: Binding<[Chapter]>, coverPage: Binding<CoverPage>, currentChapterIndex: Binding<Int?>, currentPageIndex: Binding<Int>) {
        self._chapters = chapters
        self._coverPage = coverPage
        self._currentChapterIndex = currentChapterIndex
        self._currentPageIndex = currentPageIndex
        self.chaptersWithQuestionVMs = convertToVMs(chapters: chapters)
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        coordinator.chaptersWithQuestionVMs = self.chaptersWithQuestionVMs
        return coordinator
    }
    
    // Convert the struct Chapter into obervable objects
    func convertToVMs(chapters: Binding<[Chapter]>) -> [ChapterWithQuestionVM] {
        var convertedChapters: [ChapterWithQuestionVM] = []
        let factory = DefaultQuestionViewModelFactory()
        
        // Iterate over each chapter
        for chapter in chapters.wrappedValue {
                var questionVMs: [QuestionViewModel] = []
                // Iterate over each question in the chapter
                for question in chapter.questions {
                        let questionVM = factory.createViewModel(for: question)
                        questionVMs.append(questionVM)
                }

                // Add the ChapterWithQuestionVM to the result array
                let chapterVM = ChapterWithQuestionVM(id: chapter.id, questionVMs: questionVMs)
                convertedChapters.append(chapterVM)
            }
        return convertedChapters
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
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.goToMainPage), name: NSNotification.Name("GoToMainPage"), object: nil)
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        guard let chapterIndex = currentChapterIndex else {
            return
        }
        
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
        
        var chaptersWithQuestionVMs: [ChapterWithQuestionVM] = []
        
        
        init(_ pageCurlViewController: PageCurlViewController) {
            self.parent = pageCurlViewController
        }
        
        func createHostingController(for pageIndex: Int, in chapterIndex: Int) -> UIViewController {
            // Check if it's the landing page
            print("Chapter index: \(chapterIndex) - Page index: \(pageIndex)")
            if chapterIndex == 0 {
                return UIHostingController(rootView: BookDetailView(page: parent.$coverPage))

            } else {
                let question = self.chaptersWithQuestionVMs[chapterIndex].questionVMs[pageIndex]
                
                // Decide which view to render based on the question type
                
                if let mcVM = question as? MutipleChoiceViewModel {
                    return UIHostingController(rootView: MultipleChoiceView(questionVM: mcVM))
                }
                
                else if let matchingVM = question as? MatchingGameViewModel {
                    return UIHostingController(rootView: MatchingGameView(viewModel: matchingVM))
                }
                
                
                else if let timelineVM = question as? TimelineGameViewModel {
                    return UIHostingController(rootView: TimelineGameView(viewModel: timelineVM))
                }
                
                else if let fillVM = question as? FillInBlankViewModel {
                    return UIHostingController(rootView: FillInBlankGameView(viewModel: fillVM))
                }
                
                else if let mapVM = question as? MapViewModel {
                    return UIHostingController(rootView: MapViewManager(viewModel: mapVM))
                }
                
                
                // Fallback to a default view if no match is found (optional)
                return UIHostingController(rootView: Text("Unknown question type"))
            }
            
        }
        
        
        // Handle the "Next Page" button press notification
        @objc func goToNextPage() {
            guard let pageViewController = pageViewController else { return }
            guard let currentVC = pageViewController.viewControllers?.first else { return }
            
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex
            
            
            // Find the next view controller
            if let nextViewController = self.pageViewController(pageViewController, viewControllerAfter: currentVC) {
                if parent.currentPageIndex < chaptersWithQuestionVMs[chapterIndex].questionVMs.count - 1 {
                    parent.currentPageIndex += 1
                } else if chapterIndex < parent.chapters.count - 1 {
                    parent.currentChapterIndex = chapterIndex + 1
                    parent.currentPageIndex = 0
                }
                pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            }
        }
        
        @objc func goToMainPage() {
            parent.currentChapterIndex = 0
            parent.currentPageIndex = 0
            
            print("current chapter: \(String(describing: parent.currentChapterIndex))" )
            if let pageViewController = pageViewController {
                let landing = createHostingController(for: 0, in: 0)
                pageViewController.setViewControllers(
                    [landing],
                    direction: .reverse,
                    animated: true,
                    completion: nil
                )
            }
        }
        
        // Handle swipe to the previous page
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex
            
            if !parent.canFlip {
                return nil
            }
            
            if pageIndex > 0 {
                parent.currentPageIndex = pageIndex - 1
                return createHostingController(for: parent.currentPageIndex, in: chapterIndex)
            } else if chapterIndex > 0 {
                parent.currentChapterIndex = chapterIndex - 1
                parent.currentPageIndex = parent.chapters[chapterIndex - 1].questions.count - 1
                return createHostingController(for: parent.currentPageIndex, in: parent.currentChapterIndex!)
            }
            return nil
        }
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let chapterIndex = parent.currentChapterIndex ?? 0
            let pageIndex = parent.currentPageIndex
            
            if !parent.canFlip {
                return nil
            }
            // Check if there are more pages in the current chapter
            if pageIndex < parent.chapters[chapterIndex].questions.count - 1 {
                // Move to the next page within the current chapter
                parent.currentPageIndex = pageIndex + 1
                return createHostingController(for: parent.currentPageIndex, in: chapterIndex)
            } else if chapterIndex < parent.chapters.count - 1 {
                // If there are no more pages, move to the first page of the next chapter
                parent.currentChapterIndex = chapterIndex + 1
                parent.currentPageIndex = 0
                return createHostingController(for: parent.currentPageIndex, in: parent.currentChapterIndex!)
            }
            
            // No more pages or chapters to flip to
            return nil
        }

        
        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first {
                // Identify the view type
                if let hostingController = visibleViewController as? UIHostingController<MultipleChoiceView> {
                    let questionVM = hostingController.rootView.questionVM
                    if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].questions.firstIndex(where: { $0.id == questionVM.question.id }) {
                        parent.currentPageIndex = pageIndex
                        parent.canFlip = true
                    }
                } else if let hostingController = visibleViewController as? UIHostingController<MatchingGameView> {
                    let questionVM = hostingController.rootView.viewModel
                    if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].questions.firstIndex(where: { $0.id == questionVM.question.id }) {
                        parent.currentPageIndex = pageIndex
                        parent.canFlip = true
                    }
                } else if let hostingController = visibleViewController as? UIHostingController<TimelineGameView> {
                    let questionVM = hostingController.rootView.viewModel
                    if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].questions.firstIndex(where: { $0.id == questionVM.question.id }) {
                        parent.currentPageIndex = pageIndex
                        parent.canFlip = false
                    }
                } else if let hostingController = visibleViewController as? UIHostingController<FillInBlankGameView> {
                    let questionVM = hostingController.rootView.viewModel
                    if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].questions.firstIndex(where: { $0.id == questionVM.question.id }) {
                        parent.currentPageIndex = pageIndex
                        parent.canFlip = true
                    }
                }
                else if let hostingController = visibleViewController as? UIHostingController<MapViewManager> {
                    let questionVM = hostingController.rootView.viewModel
                    if let pageIndex = parent.chapters[parent.currentChapterIndex ?? 0].questions.firstIndex(where: { $0.id == questionVM.question.id }) {
                        parent.currentPageIndex = pageIndex
                        parent.canFlip = true
                    }
                }
                
            }
        }
    }
}
