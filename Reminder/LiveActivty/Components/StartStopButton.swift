//
//  StartStopButton.swift
//  Rehat
//
//  Created by Darren Thiores on 24/06/24.
//

import SwiftUI

struct StartStopButton: View {
    let iconName: String
    let bgColor: Color
    let intent: ReminderLAIntent
    
    var body: some View {
        Button(intent: intent) {
            ZStack {
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            .frame(width: 45, height: 45)
            .contentShape(Circle())
            .background(
                Circle()
                    .foregroundStyle(bgColor)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    StartStopButton(
        iconName: "stop.fill",
        bgColor: .buttonRed,
        intent: ReminderLAIntent()
    )
}
