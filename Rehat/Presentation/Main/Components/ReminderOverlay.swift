//
//  ReminderOverlay.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import SwiftUI

struct ReminderOverlay: View {
    let countDown: Int
    let onEvent: (MainEvent) -> Void
    
    @AppStorage(
        "status",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var status: String?
    
    //Load user default kemudian simpan ke konstanta let terus return
    @AppStorage(
        "currency",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var currency: Int = 0
    
    private var currentMinute: String {
        let minute = countDown / 60
        
        if minute <= 9 {
            if minute <= 0 {
                return "00"
            } else {
                return "0\(minute)"
            }
        } else {
            return "\(minute)"
        }
    }
    private var currentSecond: String {
        let second = countDown % 60
        
        if second <= 9 {
            if second <= 0 {
                return "00"
            } else {
                return "0\(second)"
            }
        } else {
            return "\(second)"
        }
    }
    
    private var reminderStatus: ReminderStatus {
        if let status = status {
            return ReminderStatus(rawValue: status) ?? .NotSet
        } else {
            return .NotSet
        }
    }
    
    var body: some View {
        VStack {
            CurrencyView(currency: currency)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 8) {
                if reminderStatus == .Set {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Rest in:")
                            .font(.headline)
                            .foregroundStyle(.textGreen)
                        
                        Text("\(currentMinute):\(currentSecond)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.textGreen)
                    }
                } else {
                    Text("Reminder not activated")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.textGreen)
                }
                
                Spacer()
                
                DefaultButton(
                    text: reminderStatus.buttonText(),
                    onClick: {
                        if reminderStatus == .Set {
                            onEvent(.StopReminder)
                            
                            
                        } else {
                            onEvent(.StartReminder)
                        }
                    },
                    bgColor: reminderStatus == .NotSet ? .buttonYellow : .softRed,
                    bordered: true
                )
                .frame(width: 200)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(.white)
        }
        .padding(.top, 16)
    }
}

#Preview {
    ReminderOverlay(
        countDown: 1000,
        onEvent: { _ in }
    )
    .background(.cream)
}
