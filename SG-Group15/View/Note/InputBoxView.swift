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

struct InputBoxView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @State private var isVisible = false
    @Binding var note: Note
    @Binding var selectedColor: String
    @Binding var showInput: Bool
    
    @State private var inputTitle: String = ""
    
    var colorList = ["bookmarkColor1", "bookmarkColor2", "bookmarkColor3", "correctButton", "lightRed", "primaryRed"]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // Define a two-column grid with flexible items

    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: horizontalSizeClass == .compact ? 350 : 450, height: horizontalSizeClass == .compact ? 350 : 520)
                    .foregroundColor(.beigeBackground)
                
                VStack(spacing: horizontalSizeClass == .compact ? 30 : 40) {
                    Text("Ghi chú mới")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(Title2TextModifier()) : AnyViewModifier(Title2TextModifierIpad()))
                        
                    VStack(alignment: .center, spacing: 10) {
                        HStack {
                            Text("Tiêu đề: ")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                            
                            TextField("Nhập tiêu đề", text: $inputTitle)
                                .frame(width: horizontalSizeClass == .compact ? 200 : 260)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.beigeBackground, lineWidth: 1)
                                    )
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        }
                        
                        HStack {
                            Text("Màu: ")
                                .modifier(horizontalSizeClass == .compact ? AnyViewModifier(SubHeadlineTextModifier()) : AnyViewModifier(SubHeadlineTextModifierIpad()))
                            
                            Spacer()
                        }
                        
                        HStack {
                            LazyVGrid(columns: columns, spacing: horizontalSizeClass == .compact ? 15 : 20) {
                                ForEach(Array(zip(self.colorList.indices, self.colorList)), id: \.0, content: { index, color in
                                        ColorPicker(selectedColor: $selectedColor, color: color)
                                })
                            }
                            .padding(.horizontal, 50)
                        }
                    
                    }
//                    .padding(10)
//                    .background(.green)
                    .frame(width: horizontalSizeClass == .compact ? 300 : 400)
                    
                    Button("Tạo") {
                        withAnimation{
                            isVisible = false
                            note.title = inputTitle
                            note.color = selectedColor
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showInput = false
                            }
                        }
                    }
                    .modifier(horizontalSizeClass == .compact ? AnyViewModifier(HeadlineTextModifier()) : AnyViewModifier(HeadlineTextModifierIpad()))
                    .foregroundColor(.white)
                    .frame(width: horizontalSizeClass == .compact ? 150 : 200, height: horizontalSizeClass == .compact ? 40 : 60)
                    .background(.primaryRed)
                    .foregroundStyle(.white)
                    .cornerRadius(20)
                // Ajust shadow to be responsive
                    .shadow(radius: 4, x: 1, y: UIScreen.main.bounds.width * 0.015)
            
                }
            }
            .frame(width: size.width, height: size.height)
            .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isVisible = true
                }
            }
        }
    }
}

#Preview {
    InputBoxView(note: .constant(Note(id: "123", title: "", color: "")), selectedColor: .constant("pink"), showInput: .constant(true))
}
