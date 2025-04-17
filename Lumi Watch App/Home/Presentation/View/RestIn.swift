//
//  TextView.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

struct RestIn: View {
    
    
    //TODO: INI MASIH BANYAK YANG HARUS DIBENERIN
    //set 20 menitnya disini
    
    
    
    @State private var currentReminderType: ReminderStatus = .NotSet
    @State private var timeRemaining : Int = 60 // anggepannya 20 min
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let textSubtitle = "Rest in"
    private let textColor = Color(hex: "FFE9C9")
    private let myBackgroundColor = Color(hex: "3F9287")
    private let paddingValue: CGFloat = 22
    
    private var currentMinute: String {
        String(format: "%02d", timeRemaining / 60)
    }
    
    private var currentSecond: String {
        String(format: "%02d", timeRemaining % 60)
    }
    
    
    
    
    var body: some View {
        ZStack {
            Rectangle().ignoresSafeArea(.all).foregroundStyle(myBackgroundColor)
            VStack(alignment: .leading){
                Text(textSubtitle)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .padding([.trailing, .leading], 22 )
                    .padding(.top)
                    .foregroundColor(textColor)
                
                Text("\(currentMinute):\(currentSecond)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.trailing, .leading], 22 )
                    .padding(.top, 5.0)
                    .foregroundColor(textColor)
                
                Button(action: {
                    print("Stop Reminder Pressed!")
                    
                }) {
                    Text(currentReminderType.rawValue)
                }
                .buttonStyle(CustomReminderButton(buttonType: currentReminderType))
                .padding([.trailing, .leading], paddingValue)
                .padding(.top, 15)
                
            }.onReceive(timer) { time in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
        }
        
    }
}

#Preview {
    RestIn()
}
