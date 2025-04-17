//
//  ButtonLookAround.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 24/06/24.
//
import SwiftUI

struct CustomRestButtons: ButtonStyle {
    // Constants
    private let backgroundColor = Color(hex: "E8F3B0")
    private let textColor = Color(hex: "155948")
    private let strokeColor = Color(hex: "3F9287")
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.system(size: 16))
            .fontWeight(.bold)
            .foregroundStyle(textColor)
            .background(
                Circle()
                    .fill(backgroundColor)
                    .overlay(
                        Circle()
                            .stroke(textColor, lineWidth: 3)
                    )
                    .frame(width: 152, height: 152)
            )
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
    }
}

struct RestButton: View {
    let textInButton = "Press to \n begin eye rest "
    let textColor = Color(hex: "FFE9C9")
    let myBackgroundColor = Color(hex: "3F9287")
    let onClick: () -> Void
    
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Image("rest-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Button(action: {
                onClick()
            }) {
                Text(textInButton)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(CustomRestButtons())
            .scaleEffect(scale)
            .onAppear {
                startBreathingAnimation()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func startBreathingAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            scale = 0.9
        }
    }
}

#Preview {
    RestButton(onClick: { })
}
