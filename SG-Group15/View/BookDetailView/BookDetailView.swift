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

struct BookDetailView: View {
    var title: String
    var description: String
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var isScaled = false
    @State private var selectedChapter: Int = 1
    @State private var check = false
    
    func goToNextPage() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToNextPage"), object: nil)
    }
    
    var body: some View {
        ZStack {
            Color.beigeBackground
                .ignoresSafeArea(.all)
            
            Group {
                ZStack(alignment: .top) {
                    Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .zIndex(1.0)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .modifier(ShadowLeftRight(alignment: .trailing, x: 5))
                        .modifier(ShadowTopBottom(alignment: .bottom, y: 5))
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            goToChapter(chapter: 0)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(.bookmarkColor1)
                                    .frame(width: 70, height: 130)
                                
                                
                                Text("1")
                                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                                    .foregroundColor(.black)
                                
                            }
                            .zIndex(3)
                        })
                        
                        Button(action: {
                            goToChapter(chapter: 1)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(.bookmarkColor2)
                                    .frame(width: 70, height: 130)
                                
                                
                                Text("2")
                                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                                    .foregroundColor(.black)
                                
                            }
                        })
                        
                        Button(action: {
                            goToChapter(chapter: 2)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(.bookmarkColor3)
                                    .frame(width: 70, height: 130)
                                
                                
                                Text("3")
                                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                                    .foregroundColor(.black)
                                
                            }
                            .zIndex(3)
                        })

                    }
                    .padding(.top, 30)
                    .offset(x: horizontalSizeClass == .compact ? 210 : 440)
                }
                
                VStack(spacing: 40) {
                    Spacer()
                    Text(title)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(LargeTitleTextModifier()) : AnyViewModifier(LargeTitleTextModifierIpad()))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text(description)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        .lineSpacing(10.0)
                    
                    Spacer()
                    
                    Text("Ân bên phải để lật sách, ấn bên trái để quay về")
//                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        .multilineTextAlignment(.center)

                    
                    .onChange(of: isScaled, initial: false) { _, newValue in
                        if newValue {
                            // Once scaled up, trigger a slight delay before flipping
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                NotificationCenter.default.post(name: NSNotification.Name("GoToChapter"), object: selectedChapter)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
            .scaleEffect(isScaled ? 1.05 : 0.8)
            .animation(.easeIn(duration: 0.5), value: isScaled) // Scale up animation
            .onAppear {
                withAnimation {
                    isScaled = false
                }
            }
        }
    }
    
    func goToChapter(chapter: Int) {
        NotificationCenter.default.post(name: NSNotification.Name("GoToChapter"), object: chapter)
    }
    
    func goToCurrentChapter() {
        NotificationCenter.default.post(name: NSNotification.Name("GoToCurrentChapter"), object: nil)
    }
}

//#Preview {
//    BookView()
//}
