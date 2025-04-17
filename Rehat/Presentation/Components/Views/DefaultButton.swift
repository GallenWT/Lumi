//
//  DefaultButton.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import SwiftUI

struct DefaultButton: View {
    @State private var isScaleAnimating = false
    
    let text: String
    let onClick: () -> Void
    var textColor: Color = .textGreen
    var textFont: Font = .title2
    var bgColor: Color = .yellow
    var height: CGFloat = 60
    var radius: CGFloat = 24
    var bordered: Bool = false
    var sidePadding: CGFloat = 12
    
    var body: some View {
        Button {
            withAnimation(
                .easeInOut(duration: 0.5)
            ) {
                onClick()
                isScaleAnimating.toggle()
            }
        } label: {
            Text(text)
                .font(textFont)
                .fontWeight(.bold)
                .padding(sidePadding)
                .frame(maxWidth: .infinity, minHeight: height)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(bgColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(
                                    .textGreen,
                                    lineWidth: bordered ? 5 : 0
                                )
                        )
                )
                .foregroundStyle(textColor)
        }
        .clipShape(RoundedRectangle(cornerRadius: radius))
        .buttonStyle(.plain)
        .scaleEffect(isScaleAnimating ? 1.2 : 1.0)
        .onChange(of: isScaleAnimating) {
            if isScaleAnimating {
                withAnimation(
                    .easeInOut(duration: 0.5)
                ) {
                    isScaleAnimating.toggle()
                }
            }
        }
    }
}

#Preview {
    DefaultButton(
        text: "Start Reminder",
        onClick: {  },
        bordered: true
    )
}
