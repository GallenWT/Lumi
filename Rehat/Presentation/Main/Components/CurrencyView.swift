//
//  CurrencyView.swift
//  Rehat
//
//  Created by Darren Thiores on 21/06/24.
//

import SwiftUI

struct CurrencyView: View {
    let currency: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("\(currency)")
                .font(.subheadline)
                .foregroundStyle(.textGreen)
                .frame(minWidth: 100, minHeight: 32)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.textGreen, lineWidth: 2)
                        )
                )
                .offset(x: 20)
            
            Image("coin")
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
        }
    }
}

#Preview {
    CurrencyView(
        currency: 0
    )
}
