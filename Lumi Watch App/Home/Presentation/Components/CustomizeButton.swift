//
//  ButtonStartReminder.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI



struct CustomizeButton: View {
    
    @State private var currentReminderType: ReminderStatus = .NotSet

    var body: some View {
        VStack{
            Button(action: {

            }){
                Text(currentReminderType.rawValue)
            }
            .buttonStyle(CustomReminderButton(buttonType: currentReminderType))
            .padding()

        }
    }
}

#Preview {
    CustomizeButton()
}



