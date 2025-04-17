//
//  Reward.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 24/06/24.
//

import SwiftUI

struct Reward: View {
    //Constant Value
    private let getGreatRewardText = "Great work today!"
    private let youDoneTotalOfText = "You’ve done a total of"
    private let youGainedTotalOfText = "You’ve gained a total of"
    
    private let paddingBottomSizeNumber = 6.0
    private let paddingLeftAndRightSizeNumber = 20.0
    private let fontTitleSizeNumber = 16.0
    private let fontSubtitleSizeNumber = 13.0
    
    private let textColor = Color("TextGreen")
    private let containerColor = Color("Cream")
    
    @AppStorage("cycleCount") var cycleCount: Int = 0
    
    private var totalCoin: Int {
        cycleCount * 10
    }
    
    private let reminderWCDelegate = ReminderWCDelegate()
    private let reminderDefaults = ReminderDefaults.shared
    
    var body: some View {
        
        ZStack {
            Image("reward-background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack{
                Text(getGreatRewardText)
                    .font(.system(size: fontTitleSizeNumber, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(textColor)
                    .padding(.bottom, paddingBottomSizeNumber)
                
                Text(youDoneTotalOfText)
                    .font(.system(size: fontSubtitleSizeNumber, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundStyle(textColor)
                
                ZStack{
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .foregroundStyle(containerColor)
                        .frame(width: 130, height: 40)
                        .padding(.horizontal, paddingLeftAndRightSizeNumber)
                    
                    Text("^[\(cycleCount) Rest](inflect: true)")
                        .font(.system(size: fontTitleSizeNumber))
                        .fontWeight(.bold)
                        .foregroundStyle(textColor)
                }.padding(.bottom, paddingBottomSizeNumber)
                
                Text(youGainedTotalOfText)
                    .font(.system(size: fontSubtitleSizeNumber, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundStyle(textColor)
                
                ZStack{
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .foregroundStyle(containerColor)
                        .frame(width: 130, height: 40)
                        .padding([.leading, .trailing], paddingLeftAndRightSizeNumber)

                    
                    HStack{
                        Text("\(totalCoin)")
                            .font(.system(size: fontTitleSizeNumber))
                            .fontWeight(.bold)
                            .foregroundStyle(textColor)
                        
                        Image("currencyImage")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                    }
                }
            }
            
        }
        .onAppear {
            reminderWCDelegate.setup()
        }
        .onTapGesture {
            DispatchQueue.main.async {
                reminderDefaults.saveCycleCount(0)
                reminderDefaults.saveShowReward(false)
                
                reminderWCDelegate.updateCycle(cycleCount: 0)
                reminderWCDelegate.updateShowReward(showReward: false)
            }
        }
    }
}

#Preview {
    Reward()
}
