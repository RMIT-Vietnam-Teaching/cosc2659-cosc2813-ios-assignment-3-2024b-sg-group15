//
//  ChoiceButton.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct ChoiceButton: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @State private var check: Bool = false
    @Binding var correct: Bool?
    var question: MultipleChoiceQuestion
    @Binding var selected: String
    var index: Int
    
    var body: some View {
            Button(action: {
                if selected == "" {
                    withAnimation {
                        selected = question.choices[index]
                        check.toggle()
                        checkCorrect()
                    }
                }
            }, label: {
                HStack {
                    Text("\(index + 1). \(question.choices[index])")
                        .modifier(horizontalSizeClass == .compact ? AnyViewModifier(BodyTextModifier()) : AnyViewModifier(BodyTextModifierIpad()))
                        .foregroundColor(.black)
                        .padding(.vertical, 5) // Smaller vertical padding for compactness
                        .lineLimit(1) // Allows text to wrap if needed
                    
                    Spacer()
                    
                    if check && correct != nil {
                        Image(systemName: correct! ? "checkmark.circle.fill" : "x.circle.fill")
                            .resizable()
                            .frame(width: horizontalSizeClass == .compact ? 10 : 20, height: horizontalSizeClass == .compact ? 10 : 20)
                            .foregroundColor(correct! ? .green : .red)
                            .opacity(check ? 1 : 0) // Opacity animation
                            .animation(.easeInOut(duration: 0.5), value: check)
                    } else if selected != "" && question.choices[index] == question.correct {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: horizontalSizeClass == .compact ? 10 : 20, height: horizontalSizeClass == .compact ? 10 : 20)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(width: UIScreen.main.bounds.width - 60) // Fixed width, but flexible height
                .background {
                    if check && correct != nil {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(correct! ? .correctBackground : .lightRed)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(correct! ? .correctButton : .wrongBackground)
                            }
                    } else if selected != "" && question.choices[index] == question.correct {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.correctBackground)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.correctButton)
                            }
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.primaryRed)
                    }
                }
            })
    }
    
    func checkCorrect() {
        if selected == question.correct {
            correct = true
        } else {
            correct = false
        }
    }
}




