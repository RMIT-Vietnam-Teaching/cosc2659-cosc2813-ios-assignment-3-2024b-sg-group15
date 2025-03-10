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
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    private let duration: Double // How long the GIF should play
    @Binding var isVisible: Bool // Control whether the GIF is visible or not

    init(_ name: String, duration: Double, isVisible: Binding<Bool>) {
        self.name = name
        self.duration = duration
        self._isVisible = isVisible
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        
        // Disable scroll and bounces
        webview.scrollView.isScrollEnabled = false
        webview.scrollView.bounces = false
        
        // Load the GIF data
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        
        // Set the webview background to be transparent
        webview.isOpaque = false
        webview.backgroundColor = .clear
        webview.scrollView.backgroundColor = .clear
        
        // Schedule the GIF to disappear after the duration ends
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            isVisible = false // Hide the GIF after the specified duration
        }
        
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if !isVisible {
            uiView.stopLoading() // Stop the GIF when it should be hidden
            uiView.removeFromSuperview() // Remove from view when not visible
        }
    }
}

