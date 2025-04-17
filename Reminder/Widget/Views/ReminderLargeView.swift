//
//  ReminderLargeView.swift
//  Rehat
//
//  Created by Darren Thiores on 25/06/24.
//

import SwiftUI

struct ReminderLargeView: View {
    let status: ReminderStatus
    let text: String
    let buttonText: String
    let bgColor: Color
    let date: Date
    let intent: ReminderLAIntent
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            HStack(spacing: 0) {
                if (status == .Set && date >= .now) ||
                    (status == .OnBreak && date >= .now) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(text)
                            .font(.body)
                            .foregroundStyle(.textGreen)
                        
                        Text(
                            timerInterval: Date.now...date,
                            countsDown: true
                        )
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.textGreen)
                    }
                } else {
                    Text(text)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGreen)
                }
                
                Spacer()
                
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

#Preview {
    ReminderLargeView(
        status: .NotSet,
        text: "Title",
        buttonText: "Button",
        bgColor: .softRed,
        date: .now,
        intent: ReminderLAIntent()
    )
    .background(.cream)
}
