//
//  BouncyStyle.swift
//  Rehat
//
//  Created by Darren Thiores on 25/06/24.
//

import SwiftUI

struct BouncyStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.75 : 1.0)
    }
}
