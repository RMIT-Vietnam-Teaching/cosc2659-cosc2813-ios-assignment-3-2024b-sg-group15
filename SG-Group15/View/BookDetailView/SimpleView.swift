////
////  SimpleView.swift
////  SG-Group15
////
////  Created by Nana on 13/9/24.
////
//
//import SwiftUI
//
import SwiftUI
//


struct SimpleView: View {
//    @ObservedObject var page: Page  // Observes changes in the page object

    var body: some View {
        VStack {
            // Display the content of the page
            Text("content")
                .font(.system(size: 36))
                .padding()

            // Button to toggle the flip state
            Button(action: {
//                page.canFlip.toggle()
//                print(page.canFlip)
            }) {
//                Text(page.canFlip ? "Flip Enabled" : "Flip Disabled")
                Text("111")
                    .padding()
//                    .background(page.canFlip ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)

            if page.canFlip {
                // Next Page Button
                Button(action: goToNextPage) {
                    Text("Next Page")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            
            Button(action: goToMainPage) {
                Text("Main Menu")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange.edgesIgnoringSafeArea(.all))
    }

    // Function to trigger the "Next Page" action
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    func goToMainPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToMainPage"), object: nil)
    }
}

#Preview {
    SimpleView()
//    SimpleView(text: "test", backgroundColor: .green, flipState: .constant(true))
//    BookView()
}
