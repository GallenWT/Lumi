//
//  ActionTutorialOverlay.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct ActionTutorialOverlay: View {
    let text: String
    var image: String?
    let onSkipClick: () -> Void
    let reminderStatus: ReminderStatus
    let onButtonClick: () -> Void
    
    var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.65)
                .ignoresSafeArea()
            
            TutorialCard(
                text: text,
                image: image
            )
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        onSkipClick()
                    } label: {
                        Text("Skip")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundStyle(.cream)
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            
            VStack(spacing: 0) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 48) {
                        Image("HandDown")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                        
                        DefaultButton(
                            text: reminderStatus.buttonText(),
                            onClick: onButtonClick,
                            bgColor: reminderStatus == .NotSet ? .buttonYellow : .softRed
                        )
                        .frame(width: 200)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
    }
}

#Preview {
    ActionTutorialOverlay(
        text: "Welcome to **Lumi Pond**!\n\nLets help Lumi to find his friends",
        image: "WelcomeFrog",
        onSkipClick: {  },
        reminderStatus: .NotSet,
        onButtonClick: {  }
    )
}
