//
//  BoardingButton.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct BoardingButton: View {
    let text: String
    let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(.darkGreen)
                .foregroundStyle(.cream)
        }
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .buttonStyle(.plain)
    }
}

#Preview {
    BoardingButton(
        text: BoardingText.twentyButton,
        onClick: {  }
    )
}
