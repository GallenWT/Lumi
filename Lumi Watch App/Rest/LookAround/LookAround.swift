//
//  LookAround.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

struct LookAround: View {
    
    let textValueLookAround = "Look across the room or close your eyes until the timer rings"
    let paddingValue = 20.0
    let textColor = Color(hex: "FFE9C9")
    let myBackgroundColor = Color(hex: "3F9287")
    
    
    var body: some View {
        ZStack{
            Image("rest-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Text(textValueLookAround)
                .multilineTextAlignment(.center)
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    LookAround()
}
