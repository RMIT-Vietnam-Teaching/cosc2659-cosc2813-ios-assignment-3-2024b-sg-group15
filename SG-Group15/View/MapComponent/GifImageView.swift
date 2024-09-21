//
//  Untitled.swift
//  SG-Group15
//
//  Created by Anh Nguyen Ha Kieu on 21/9/24.
//

import SwiftUI
import WebKit
struct GifImageView: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
    webview.scrollView.isScrollEnabled = false
    webview.scrollView.bounces = false
    
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
    webview.isOpaque = false
    webview.backgroundColor = .clear
    webview.scrollView.backgroundColor = .clear
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

#Preview {
    GifImageView("rifle")
        .background(.pink)
}
