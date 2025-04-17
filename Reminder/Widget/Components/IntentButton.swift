//
//  IntentButton.swift
//  ReminderExtension
//
//  Created by Darren Thiores on 24/06/24.
//

import SwiftUI

struct IntentButton: View {
    let text: String
    let intent: ReminderLAIntent
    var textColor: Color = .textGreen
    var textFont: Font = .title2
    var bgColor: Color = .yellow
    var height: CGFloat = 60
    var radius: CGFloat = 24
    var bordered: Bool = false
    var sidePadding: CGFloat = 12
    
    var body: some View {
        Button(intent: intent) {
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
                                    lineWidth: bordered ? 2 : 0
                                )
                        )
                )
                .foregroundStyle(textColor)
        }
        .clipShape(RoundedRectangle(cornerRadius: radius))
        .buttonStyle(.plain)
    }
}

#Preview {
    IntentButton(
        text: "Start Reminder",
        intent: ReminderLAIntent()
    )
}
