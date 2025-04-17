//
//  AlertOverlay.swift
//  Rehat
//
//  Created by Darren Thiores on 23/06/24.
//

import SwiftUI

struct AlertOverlay: View {
    let text: String
    var onDismiss: (() -> Void)?
    var onActionClick: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color
                .black
                .opacity(0.65)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack(spacing: 24) {
                    Text(.init(text))
                        .font(.body)
                        .foregroundStyle(.textGreen)
                        .multilineTextAlignment(.center)
                    
                    if let onActionClick = onActionClick {
                        HStack(spacing: 12) {
                            DefaultButton(
                                text: "No",
                                onClick: onDismiss ?? {  },
                                textColor: .textGreen,
                                bgColor: .softRed,
                                bordered: true
                            )
                            
                            DefaultButton(
                                text: "Yes",
                                onClick: onActionClick,
                                textColor: .cream,
                                bgColor: .darkGreen,
                                bordered: true
                            )
                        }
                    }
                }
                .popUpBackground()
                
                if onActionClick == nil {
                    Text("Tap to Continue")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundStyle(.softGreen)
                }
            }
        }
    }
}

#Preview {
    AlertOverlay(
        text: MainText.restTutorialText,
        onActionClick:  {  }
    )
}
