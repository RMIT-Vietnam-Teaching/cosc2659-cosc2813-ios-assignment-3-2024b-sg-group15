//
//  NonDismissableSheet.swift
//  SG-Group15
//
//  Created by Nana on 18/9/24.
//

import Foundation
import SwiftUI

class NonDismissableHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable the swipe-to-dismiss gesture
        if let sheetPresentationController = self.presentationController as? UISheetPresentationController {
            sheetPresentationController.prefersGrabberVisible = false
            sheetPresentationController.detents = [.large()]
            sheetPresentationController.largestUndimmedDetentIdentifier = .large
        }

        isModalInPresentation = true // Prevents swipe-to-dismiss
    }
}

struct NonDismissableSheet<Content: View>: UIViewControllerRepresentable {
    
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIViewController(context: Context) -> NonDismissableHostingController<Content> {
        return NonDismissableHostingController(rootView: content)
    }

    func updateUIViewController(_ uiViewController: NonDismissableHostingController<Content>, context: Context) {}
}
