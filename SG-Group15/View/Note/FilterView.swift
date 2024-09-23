//
//  FilterView.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var isFilter: Bool
//    @Binding var note: Note
    @Binding var searchText: String
    @Binding var filter: String
    
    let filterFunction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation {
                        isFilter = isFilter == false ? true : false
                    }
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .foregroundColor(.black)
                })
                
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText, initial: true) { _, newValue in
                            filterFunction()
                        }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .stroke(lineWidth: 1)
//                        .strokeBorder(Color(colorGroup.color),lineWidth: 0.8)
                    )
            }
            .padding(.horizontal, 20)
        }
    }
}
