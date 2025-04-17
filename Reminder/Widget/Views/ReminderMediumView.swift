//
//  ReminderMediumView.swift
//  ReminderExtension
//
//  Created by Darren Thiores on 24/06/24.
//

import SwiftUI

struct ReminderMediumView: View {
    let status: ReminderStatus
    let text: String
    let buttonText: String
    let bgColor: Color
    let date: Date
    let intent: ReminderLAIntent
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    if (status == .Set && date >= .now) ||
                        (status == .OnBreak && date >= .now) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(text)
                                .font(.headline)
                                .foregroundStyle(.textGreen)
                            
                            Text(
                                timerInterval: Date.now...date,
                                countsDown: true
                            )
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.textGreen)
                            .frame(maxWidth: 144)
                        }
                    } else {
                        Text(text)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.textGreen)
                    }
                    
                    if !(status == .OnBreak && date >= .now) {
                        IntentButton(
                            text: buttonText,
                            intent: intent,
                            textFont: .subheadline,
                            bgColor: bgColor,
                            height: 48,
                            bordered: true
                        )
                        .frame(width: 144)
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderMediumView(
        status: .NotSet,
        text: "Title",
        buttonText: "Button",
        bgColor: .softRed,
        date: .now,
        intent: ReminderLAIntent()
    )
    .background(.cream)
}
