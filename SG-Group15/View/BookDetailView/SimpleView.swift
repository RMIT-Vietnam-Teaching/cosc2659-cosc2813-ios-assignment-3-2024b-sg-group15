//
//  SimpleView.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct SimpleView: View {
    let text: String
    let backgroundColor: Color
    @Binding var flipState: Bool

    var body: some View {
        VStack {
            // Label
            Text(text)
                .font(.system(size: 36))
                .multilineTextAlignment(.center)
                .padding(.top, 100)

            Spacer()

            Button(action: {
                
            }) {
                Text("Flip")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 50)

            // Back Button
            Button(action: goBackToMainPage) {
                Text("Back to Main Page")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.edgesIgnoringSafeArea(.all)) // Set background color
       
    }

    // Function to go back to the main page
    func goBackToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
//        print(
    }
    
    func goNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
//        print(
    }
}

#Preview {
    SimpleView(text: "test", backgroundColor: .green, flipState: .constant(true))
}
