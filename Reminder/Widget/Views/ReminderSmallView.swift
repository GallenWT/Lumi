//
//  ReminderSmallView.swift
//  Rehat
//
//  Created by Darren Thiores on 24/06/24.
//

import SwiftUI

struct ReminderSmallView: View {
    let status: ReminderStatus
    let text: String
    let assetName: String
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
                            .font(.subheadline)
                            .foregroundStyle(.textGreen)
                        
                        Text(
                            timerInterval: Date.now...date,
                            countsDown: true
                        )
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.textGreen)
                    }
                } else {
                    Text(text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGreen)
                }
                
                Spacer()
                
                if !(status == .OnBreak && date >= .now) {
                    if status == .Set && date <= .now {
                        ImageButton(
                            imageName: assetName,
                            bgColor: bgColor,
                            intent: intent
                        )
                    } else {
                        IconButton(
                            iconName: assetName,
                            bgColor: bgColor,
                            intent: intent
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderSmallView(
        status: .NotSet,
        text: "Title",
        assetName: "play.fill",
        bgColor: .softRed,
        date: .now,
        intent: ReminderLAIntent()
    )
    .background(.cream)
}
