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
