//
//  ReminderText.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

struct ReminderText: View {
    let title: String = "Reminder \nnot activated"
    let textColor: Color = Color("TextGreen")
    
    
    var body: some View {
        VStack(alignment: .leading) {
//            Text(title)
//                .font(.system(size: 12))
//                .fontWeight(.medium)
//                .padding(.trailing)
//                .padding(.leading, 13)
//                .padding(.top)
//                .foregroundColor(color)
//            
//            Text(subtitle)
//                .font(.system(size: 20))
//                .fontWeight(.bold)
//                .padding(.trailing)
//                .padding(.leading, 13)
//                .padding(.top, 5)
//                .foregroundColor(color)
            
            Text (title)
                .font(.system(size: 20, design: .rounded))
                .foregroundStyle(textColor)
                .fontWeight(.bold)
                .lineSpacing(6)
        }
    }
}


#Preview {
    ReminderText()
}
