//
//  LoadingView.swift
//  SG-Group15
//
//  Created by Xian on 22/9/24.
//

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
