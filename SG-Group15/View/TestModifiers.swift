//
//  TestModifiers.swift
//  SG-Group15
//
//  Created by Xian on 13/9/24.
//

import Foundation
import SwiftUI

struct TestModifiers: View {
    var body: some View {
        Button(action: {
            
        })
        {
            Text("Học")
                .modifier(LargeButtonModifier(background: Color.primaryRed))
        }
        Button(action: {
            
        })
        {
            Text("Tiếp tục")
                .modifier(LargeButtonModifier(background: Color.correctButton))
        }
    }
}

struct TestModifiers_Preview: PreviewProvider {
    static var previews: some View {
        TestModifiers()
    }
}
