//
//  ContentView.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        WelcomeView()
//        TabViewNote()
        TimelineGameView(
            eventData: ["Thời cơ Cách mạng tháng 8", "Tuyên Ngôn Độc Lập", "Vua Bảo Đại thoái vị", "Chính phủ kí sắc lệnh phát hành tiền Việt Nam"],
            periodData: ["15/8/1945", "2/9/1945", "30/8/1945", "31/1/1946"]
        )
//        BookDetailView(page: .constant(CoverPage(title: "11", content: "11")))
    }
}

#Preview {
    ContentView()
}
