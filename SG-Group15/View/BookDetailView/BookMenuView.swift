//
//  BookMenuView.swift
//  SG-Group15
//
//  Created by Nana on 19/9/24.
//

import SwiftUI

struct BookMenuView: View {
    @State private var currentTab: Int = 0
    var books: [String] = ["book1", "book2"]
    
    var body: some View {
        GeometryReader { geo in
//            Color.beigeBackground
//                .ignoresSafeArea()
            
            TabView(selection: $currentTab,
                    content:  {
//                ForEach(Array(zip(books.indices, books)), id: \.0) { index, book in
//                    Book().tag(index)
//                }
                BookView(coverPage: CoverPage(title: "123", content: "123")).tag(0)
                
                BookView(coverPage: CoverPage(title: "123", content: "123")).tag(1)
                   

            })
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
    }
}

#Preview {
    BookMenuView()
}
