//
//  TutorialCard.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct TutorialCard: View {
    let text: String
    var image: String?
    var tapToContinue: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .offset(y: 50)
            }
            
            VStack(spacing: 16) {
                Text(.init(text))
                    .font(.body)
                    .foregroundStyle(.textGreen)
                    .multilineTextAlignment(.center)
                    .popUpBackground()
                
                if tapToContinue {
                    Text("Tap to Continue")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundStyle(.softGreen)
                }
            }
        }
        .offset(y: -50)
    }
}

#Preview {
    TutorialCard(
        text: "Welcome to **Lumi Pond**!\n\nLets help Lumi to find his friends",
        image: "WelcomeFrog",
        tapToContinue: true
    )
}
