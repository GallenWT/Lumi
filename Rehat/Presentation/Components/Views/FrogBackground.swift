//
//  FrogBackground.swift
//  Rehat
//
//  Created by Darren Thiores on 23/06/24.
//

import SwiftUI

struct FrogBackground: View {
    var color: Color = .mediumGreen
    var flip: Bool = true
    let proxy: GeometryProxy
    
    private var width: CGFloat {
        proxy.size.width
    }
    private var height: CGFloat {
        proxy.size.height
    }
    private var frogOffset: CGFloat {
        flip ? (height - width * 0.9) : -(height - width * 0.9)
    }
    private var earOffset: CGFloat {
        -(width * 0.2)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .frame(width: width)
            
            HStack(spacing: width * 0.2) {
                Ellipse()
                    .frame(
                        width: width * 0.3,
                        height: width * 0.2
                    )
                    .rotationEffect(.degrees(15))
                
                Ellipse()
                    .frame(
                        width: width * 0.3,
                        height: width * 0.2
                    )
                    .rotationEffect(.degrees(-15))
            }
            .offset(y: earOffset)
        }
        .foregroundStyle(color)
        .rotationEffect(.degrees(flip ? 180 : 0))
        .offset(y: frogOffset)
    }
}

#Preview {
    GeometryReader { proxy in
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            
            FrogBackground(
                flip: true,
                proxy: proxy
            )
        }
    }
}
