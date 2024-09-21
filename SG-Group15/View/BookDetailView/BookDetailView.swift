//
//  BookDetailViewIphone.swift
//  SG-Group15
//
//  Created by Nana on 13/9/24.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var isScaled = false
    @State private var selectedChapter: Int? = nil
    @State private var check = false
    @Binding var page: CoverPage
    
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
                            goToChapter(chapter: 1)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(.bookmarkColor1)
                                    .frame(width: 70, height: 130)
                                   
                                
                                Text("1")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                   
                            }
                            .zIndex(3)
                        })
                        
                        Button(action: {
                            goToChapter(chapter: 2)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(.bookmarkColor2)
                                    .frame(width: 70, height: 130)
                                   
                                
                                Text("2")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                   
                            }
                        })
                    }
                    .padding(.top, 30)
                    .offset(x: horizontalSizeClass == .compact ? 210 : 440)
                }
                     
                VStack(spacing: 40) {
                    Spacer()
                    Text("CÁCH MẠNG THÁNG 8 - 1945")
//                        .font(.title)
//                        .fontWeight(.bold)
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(TitleTextModifier()) : AnyViewModifier(TitleTextModifierIpad()))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas nibh sit amet feugiat dictum. ")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        .lineSpacing(10.0)
                    
                    Spacer()
                    
                    Button(action: {
                        goToCurrentChapter()
                    }, label: {
<<<<<<< HEAD
                            Text("Học")
//                            .foregroundColor(.white)
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubTitleTextModifier()) : AnyViewModifier(LongQuestionTextModifierIpad()))
                            .modifier(horizontalSizeClass == .compact ? AnyViewModifier(ButtonModifier(background: .bookmarkColor1)) : AnyViewModifier(ButtonModifier(background: .bookmarkColor1)))
                        }
                        
                    })
                    .accessibilityLabel("Học")
                    .accessibilityHint("Bắt đầu học")
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


#Preview {
    BookDetailView(page: .constant(CoverPage(title: "11", content: "11")))
}
