//
//  IconButton.swift
//  Rehat
//
//  Created by Darren Thiores on 25/06/24.
//

import SwiftUI

struct IconButton: View {
    let iconName: String
    let bgColor: Color
    let intent: ReminderLAIntent
    
    var body: some View {
        Button(intent: intent) {
            ZStack {
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundStyle(.textGreen)
            }
            .frame(width: 44, height: 44)
            .contentShape(RoundedRectangle(cornerRadius: 20))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(bgColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.textGreen, lineWidth: 2)
                    }
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    IconButton(
        iconName: "stop.fill",
        bgColor: .buttonRed,
        intent: ReminderLAIntent()
    )
}
