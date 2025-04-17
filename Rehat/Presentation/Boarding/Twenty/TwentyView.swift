//
//  TwentyView.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct TwentyView: View {
    @StateObject private var twentyVM = TwentyViewModel()
    
    var body: some View {
        BoardingContent(
            title: BoardingText.twentyTitle,
            description: BoardingText.twentyDescription,
            buttonText: BoardingText.twentyButton,
            onButtonClick: {
                twentyVM.onEvent(event: .Continue)
            },
            illustration: {
                Image("20-20-20")
                    .resizable()
                    .scaledToFit()
            }
        )
    }
}

#Preview {
    TwentyView()
}
