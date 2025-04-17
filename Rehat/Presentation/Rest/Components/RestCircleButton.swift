//
//  CircleButton.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import SwiftUI

struct RestCircleButton: View {
    @State private var isScaleAnimating = false
    let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
            isScaleAnimating.toggle()
        } label: {
            Text("Press to\nstart Rest")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.textGreen)
                .frame(width: 240, height: 240)
                .background(
                    Circle()
                        .foregroundStyle(.softGreen)
                        .overlay(
                            Circle()
                                .stroke(
                                    .textGreen,
                                    lineWidth: 10
                                )
                        )
                )
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .scaleEffect(isScaleAnimating ? 0.75 : 1.0)
        .onAppear {
            withAnimation(isScaleAnimating ? .easeInOut(duration: 1.0) : .easeInOut(duration: 1.0).repeatForever()
            ) {
                isScaleAnimating.toggle()
            }
        }
    }
}

#Preview {
    RestCircleButton(
        onClick: {  }
    )
}
