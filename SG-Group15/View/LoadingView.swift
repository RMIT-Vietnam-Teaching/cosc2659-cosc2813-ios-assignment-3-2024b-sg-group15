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

struct LoadingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack(alignment: .top) {
            Color.beigeBackground
                .ignoresSafeArea(.all)
            VStack(spacing: UIScreen.main.bounds.width * 0.02) {
                Spacer()
                    .frame(height: UIScreen.main.bounds.width * 0.2)
                Image("thinking")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4)
                Text("Đang tải dữ liệu...")
                    .modifier(TitleTextModifier())
                    .foregroundStyle(Color.textDark)
            }
        }
    }
}

#Preview {
    LoadingView()
}
