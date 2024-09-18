//
//  ChoiceButton.swift
//  SG-Group15
//
//  Created by Nana on 15/9/24.
//

import SwiftUI

struct ChoiceButton: View {
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
                    correct = question.checkAnswer(selected)
                }
            }
        }, label: {
            HStack {
                Text("\(index + 1). \(question.choices[index])")
                    .modifier(BodyTextModifier())
                    .foregroundColor(.black)
                    .padding(.vertical, 5) // Smaller vertical padding for compactness
                    .lineLimit(1) // Allows text to wrap if needed
                
                Spacer()
                
                if check && correct != nil {
                    Image(systemName: correct! ? "checkmark.circle.fill" : "x.circle.fill")
                        .foregroundColor(correct! ? .green : .red)
                        .opacity(check ? 1 : 0) // Opacity animation
                        .animation(.easeInOut(duration: 0.5), value: check)
                } else if selected != "" && question.choices[index] == question.correct {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
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
    
}

#Preview {
    //    MultipleChoiceViewIphone()
    MultipleChoiceViewIpad()
    //    ChoiceButton()
}


@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
