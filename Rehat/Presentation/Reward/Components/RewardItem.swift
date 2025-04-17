//
//  RewardItem.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import SwiftUI

struct RewardItem: View {
    let text: String
    var image: String?
    
    var body: some View {
        HStack(spacing: 12) {
            Text(.init(text))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.textGreen)
            
            if let image = image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .frame(minWidth: 160, minHeight: 60)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {
    RewardItem(
        text: "10",
        image: "coin"
    )
    .background(.softGreen)
}
