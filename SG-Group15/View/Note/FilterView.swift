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

struct FilterView: View {
    @Binding var isFilter: Bool
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
