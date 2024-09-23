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
