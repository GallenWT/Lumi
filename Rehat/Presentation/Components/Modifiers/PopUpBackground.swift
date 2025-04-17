//
//  PopUpBackground.swift
//  Rehat
//
//  Created by Darren Thiores on 23/06/24.
//

import SwiftUI

struct PopUpBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(32)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.cream)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                .darkGreen,
                                lineWidth: 5
                            )
                    )
            )
            .padding(.horizontal, 64)
    }
}
