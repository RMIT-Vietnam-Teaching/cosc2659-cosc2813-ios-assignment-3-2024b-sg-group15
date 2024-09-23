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

struct ProgressBar: View {
    @State var progress: CGFloat = 0.65
    
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.butteryWhite)
                .frame(width: geo.size.width, height: 25, alignment: .center)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 1)
                        .frame(width: geo.size.width, height: 25, alignment: .center)
                        .foregroundColor(.blue)
                }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: progress * geo.size.width, height: 25)
//                .offset(x: 5)
                .foregroundColor(.primaryRed)
                .animation(.spring(response: 1.0, dampingFraction: 1.0, blendDuration: 1.0), value: progress)
            
        }
        .padding(.horizontal, 30)
        .frame(height: 25)
    }
}

#Preview {
    ProgressBar()
}
