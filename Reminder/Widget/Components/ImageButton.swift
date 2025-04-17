//
//  ImageButton.swift
//  Rehat
//
//  Created by Darren Thiores on 25/06/24.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String
    let bgColor: Color
    let intent: ReminderLAIntent
    
    var body: some View {
        Button(intent: intent) {
            ZStack {
                Image(imageName)
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
    ImageButton(
        imageName: "ClosedEye",
        bgColor: .buttonRed,
        intent: ReminderLAIntent()
    )
}
