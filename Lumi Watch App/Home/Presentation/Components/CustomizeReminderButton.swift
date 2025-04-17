//
//  CustomizeButtonViewModel.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI
struct CustomReminderButton: ButtonStyle{
    let buttonType: ReminderStatus
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundStyle(.textGreen)
            .background(
                RoundedRectangle(cornerRadius: 22.0)
                    .fill(buttonType == .NotSet ? .buttonYellow : .softRed)
                    .stroke(.textGreen, lineWidth: 3)
                    .frame(width: 172,height: 56))
    }
    
}
