//
//  RewardView.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import SwiftUI

struct RewardView: View {
    @AppStorage(
        "cycleCount",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var cycleCount: Int = 0
    
    private var totalCoin: Int {
        cycleCount * 10
    }
    
    private let reminderWCDelegate = ReminderWCDelegate()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                
                VStack(spacing: 32) {
                    Text("Great work\ntoday!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.textGreen)
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 12) {
                        Text("You’ve done a total of")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.textGreen)
                            .multilineTextAlignment(.center)
                        
                        RewardItem(text: "^[\(cycleCount) Rest](inflect: true)")
                    }
                    
                    VStack(spacing: 12) {
                        Text("You’ve gained a total of")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.textGreen)
                            .multilineTextAlignment(.center)
                        
                        RewardItem(
                            text: "\(totalCoin)",
                            image: "coin"
                        )
                    }
                }
                .padding(.horizontal, 48)
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    Text("Tap to close the page")
                        .font(.headline)
                        .foregroundStyle(.textGreen)
                }
                .padding(.bottom, 32)
            }
            .background(
                Image("RewardBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
        .onAppear {
            reminderWCDelegate.setup()
        }
        .onTapGesture {
            DispatchQueue.main.async {
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(0, forKey: "cycleCount")
                
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(false, forKey: "showReward")
                
                reminderWCDelegate.updateCycle(cycleCount: 0)
                reminderWCDelegate.updateShowReward(showReward: false)
            }
        }
    }
}

#Preview {
    RewardView()
}
