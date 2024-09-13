//
//  BookDetailViewIpad.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookDetailViewIpad: View {
    @State private var isScaled = false
    @State private var selectedChapter: Int? = nil
    @State private var check = false
    
    var body: some View {
        ZStack {
            Color("bg-color")
                .ignoresSafeArea()
            
            ZStack {
                Group {
                    ZStack(alignment: .top) {
                        Image("background")
                             .resizable()
                             .ignoresSafeArea()
                             .zIndex(1.0)
                             .clipShape(RoundedRectangle(cornerRadius: 15))
//                             .padding(.top, 30)
                             .background(
                                // Adding shadow to the bottom edge
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.black.opacity(0.2)) // Shadow color
                                    .frame(height: 10) // Shadow height
                                    .blur(radius: 5) // Blur for soft shadow
                                    .offset(y: 5), // Position the shadow
                                alignment: .bottom
                            )
                            .background(
                                // Adding shadow to the right edge
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 10) // Shadow width
                                    .blur(radius: 5)
                                    .offset(x: 5), // Position the shadow
                                alignment: .trailing
                            )
                        
                        VStack(spacing: 20) {
                            Button(action: {
                                startAnimationAndGoToChapter(1)
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .foregroundColor(Color("custom-green"))
                                        .frame(width: 70, height: 130)
                                       
                                    
                                    Text("1")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                       
                                }
//                                .zIndex(3)
                            })
                            
                            Button(action: {
                                startAnimationAndGoToChapter(2)
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .foregroundColor(Color("custom-yellow"))
                                        .frame(width: 70, height: 130)
                                       
                                    
                                    Text("2")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                       
                                }
                            })
                        }
                        .padding(.top, 30)
                        .offset(x: 440)
                    }
                    .padding(0)
                    .padding(.leading, -10)
                         
                    
                    VStack(spacing: 40) {
                        Spacer()
                        Text("CÁCH MẠNG THÁNG 8 - 1945")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
                            .font(.system(size: 30))
                            .lineSpacing(10.0)
                        
                        Spacer()
                        
                        Button(action: {
                            isScaled.toggle()
//                            startAnimationAndGoToChapter(1)
                        }, label: {
                            Text("Học")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 260, height: 70)
                                        .foregroundColor(Color("custom-red"))
                                        .background(
                                           // Adding shadow to the bottom edge
                                           RoundedRectangle(cornerRadius: 15)
                                               .fill(Color.black.opacity(0.2)) // Shadow color
                                               .frame(height: 10) // Shadow height
                                               .blur(radius: 5) // Blur for soft shadow
                                               .offset(y: 5), // Position the shadow
                                           alignment: .bottom
                                       )
                                }
                        })
                        .onChange(of: isScaled, initial: false) { _, newValue in
                            if newValue, let chapter = selectedChapter {
                                // Once scaled up, trigger a slight delay before flipping
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    NotificationCenter.default.post(name: NSNotification.Name("GoToChapter"), object: chapter)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                }
//                .padding(.vertical, 20)
                .scaleEffect(isScaled ? 1.1 : 0.8) // Initially small
                .animation(.easeIn(duration: 0.5), value: isScaled) // Scale up animation
                .onAppear {
                    withAnimation {
                        isScaled = false
                    }
                }
            }
        }
    }
    
    func startAnimationAndGoToChapter(_ chapterIndex: Int) {
        selectedChapter = chapterIndex
        isScaled = true // Trigger the scaling animation
    }
}

#Preview {
    BookDetailViewIpad()
}
