//
//  ContentView.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        TimelineGameView(
                eventData: ["CTTGT2 kết thúc", "Event2", "Event3", "Event4"],
                periodData: ["1/1111", "2/2222", "3/3333", "4/4444"]
            )
        }
    }
}

#Preview {
    ContentView()
}
