//
//  BoardingContent.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct BoardingContent<Illustration: View>: View {
    let title: String
    let description: String
    let buttonText: String
    let onButtonClick: () -> Void
    @ViewBuilder let illustration: Illustration
    
    var body: some View {
        ZStack {
            Color
                .cream
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(spacing: 18) {
                    VStack (spacing: 12) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.textGreen)
                        
                        Text(description)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.textGreen)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                    }
                    
                    illustration
                }
                
                BoardingButton(
                    text: buttonText,
                    onClick: onButtonClick
                )
            }
            .padding(24)
        }
    }
}

#Preview {
    BoardingContent(
        title: BoardingText.welcomeTitle,
        description: BoardingText.welcomeDescription,
        buttonText: BoardingText.welcomeButton,
        onButtonClick: {  },
        illustration: {
            Image("AllowNotif")
                .resizable()
                .scaledToFit()
        }
    )
}
