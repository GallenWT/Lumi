//
//  TutorialOverlay.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct TutorialOverlay: View {
    let text: String
    var image: String?
    var tapToContinue: Bool = false
    let onSkipClick: () -> Void
    
    var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.65)
                .ignoresSafeArea()
            
            TutorialCard(
                text: text,
                image: image,
                tapToContinue: tapToContinue
            )
            
            VStack(alignment: .trailing) {
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
        }
    }
}

#Preview {
    TutorialOverlay(
        text: MainText.stopTutorialText,
        image: "WelcomeFrog",
        tapToContinue: true,
        onSkipClick: {  }
    )
}
