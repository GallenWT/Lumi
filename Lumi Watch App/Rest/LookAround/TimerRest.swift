//
//  TimerRest.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 24/06/24.
//

import SwiftUI

struct TimerRest: View {
    
    //TODO: INI MASIH BANYAK YANG HARUS DIBENERIN
    @State private var timeRestRemaining : Int = 20 //set 20 detik disini
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let textColor = Color("Cream")
    var textRestFor = "Rest in"
    
    private var currentMinute: String {
        String(format: "%02d", timeRestRemaining / 60)
    }
    
    private var currentSecond: String {
        String(format: "%02d", timeRestRemaining % 60)
    }
    
    
    
    
    var body: some View {
        ZStack {
            Image("rest-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Text(textRestFor)
                    .font(.system(size: 15, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(textColor)
                
                Text("\(currentMinute):\(currentSecond)")
                    .font(.system(size: 32, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                
                
            }.onReceive(timer) { time in
                if timeRestRemaining > 0 {
                    timeRestRemaining -= 1
                }
            }
        }
        
    }
    
}

#Preview {
    TimerRest()
}
