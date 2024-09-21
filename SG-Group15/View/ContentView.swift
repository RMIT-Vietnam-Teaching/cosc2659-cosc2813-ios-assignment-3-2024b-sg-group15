//
//  ContentView.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bookVM = BookViewModel()

    var body: some View {
        Text("123")
            .onAppear {
                bookVM.fetchBook(bookID: "m9UkUeeRLMkcjqKB2eAr")
                print(bookVM.chapters.count)
            }
            
    }
}

#Preview {
    ContentView()
}
