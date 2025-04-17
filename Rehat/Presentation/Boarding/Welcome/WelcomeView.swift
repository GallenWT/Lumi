//
//  WelcomeView.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

// TODO: Handle if user don't allow notification
struct WelcomeView: View {
    @StateObject private var welcomeVM = WelcomeViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        BoardingContent(
            title: BoardingText.welcomeTitle,
            description: BoardingText.welcomeDescription,
            buttonText: BoardingText.welcomeButton,
            onButtonClick: {
                welcomeVM.onEvent(event: .AllowNotification)
            },
            illustration: {
                Image("AllowNotif")
                    .resizable()
                    .scaledToFit()
            }
        )
        .onAppear {
            welcomeVM.onEvent(event: .CheckStatus)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                welcomeVM.onEvent(event: .CheckStatus)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
