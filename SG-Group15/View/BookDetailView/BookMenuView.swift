//
//  BookMenuView.swift
//  SG-Group15
//
//  Created by Nana on 19/9/24.
//

import SwiftUI

struct BookMenuView: View {
    @StateObject private var bookVM = BookViewModel()
    @State private var currentTab: Int = 0
    @Binding var isOpen: Bool
    
    var books: [String] = [ "m9UkUeeRLMkcjqKB2eAr","QuloSOsGc5FLGbW80bR7"]
    
    var body: some View {
        GeometryReader { geo in
            Color.beigeBackground
                .ignoresSafeArea()
            
            TabView(selection: $currentTab,
                    content:  {
                BookView(bookVM: bookVM, bookID: books[0], isOpen: $isOpen).tag(0)
                BookView(bookVM: bookVM, bookID: books[1], isOpen: $isOpen).tag(1)
            })
            .ignoresSafeArea()
            .gesture(isOpen ? DragGesture().onChanged { _ in } : nil) // Disable swipe gesture when isSwipeDisabled is true
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
    }
}

#Preview {
    BookMenuView(isOpen: .constant(false))
}
