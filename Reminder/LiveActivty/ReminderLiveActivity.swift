//
//  ReminderLiveActivity.swift
//  Reminder
//
//  Created by Darren Thiores on 18/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ReminderLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ReminderAttributes.self) { context in
            var date: Date {
                context.state.date
            }
            var status: ReminderStatus {
                context.state.status
            }
            var progressColor: Color {
                if status == .Set {
                    Color.textGreen
                } else {
                    Color.buttonYellow
                }
            }
            var buttonBgColor: Color {
                if status == .Set {
                    if date <= .now {
                        Color.buttonYellow
                    } else {
                        Color.buttonRed
                    }
                } else {
                    Color.darkGreen
                }
            }
            var buttonIconName: String {
                if status == .Set {
                    if date <= .now {
                        "play.fill"
                    } else {
                        "stop.fill"
                    }
                } else {
                    "play.fill"
                }
            }
            
            var intent: ReminderLAIntent {
                switch status {
                case .NotSet:
                    let intent = ReminderLAIntent()
                    intent.status = "Set"
                    
                    return intent
                case .Set:
                    if context.state.date <= .now {
                        let intent = ReminderLAIntent()
                        intent.status = "OnBreak"
                        
                        return intent
                    } else {
                        let intent = ReminderLAIntent()
                        intent.status = "NotSet"
                        
                        return intent
                    }
                case .OnBreak:
                    let intent = ReminderLAIntent()
                    intent.status = "Set"
                    
                    return intent
                }
            }
            
            var text: String {
                switch status {
                case .NotSet:
                    "Reminder\nnot activated"
                case .Set:
                    if date <= .now {
                        "Time to rest!"
                    } else {
                        "Rest in"
                    }
                case .OnBreak:
                    if date <= .now {
                        "Start Work!"
                    } else {
                        "Start Work in"
                    }
                }
            }
            
            HStack(spacing: 8) {
                ProgressView(
                    timerInterval: Date.now...date,
                    countsDown: true,
                    label: { EmptyView() },
                    currentValueLabel: { EmptyView() }
                )
                .progressViewStyle(.circular)
                .font(.title)
                .bold()
                .tint(progressColor)
                .frame(width: 50)
                
                if (status == .Set && date >= .now) ||
                    (status == .OnBreak && date >= .now) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(text)
                            .font(.caption)
                            .foregroundStyle(.black)
                        
                        Text(
                            timerInterval: Date.now...date,
                            countsDown: true
                        )
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    }
                } else {
                    Text(text)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.cream)
                }
                
                Spacer()
                
                if !(status == .OnBreak && date >= .now) {
                    StartStopButton(
                        iconName: buttonIconName,
                        bgColor: buttonBgColor,
                        intent: intent
                    )
                }
            }
            .padding()
            .activityBackgroundTint(.white.opacity(0.4))
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            var date: Date {
                context.state.date
            }
            var status: ReminderStatus {
                context.state.status
            }
            var progressColor: Color {
                if status == .Set {
                    Color.textGreen
                } else {
                    Color.buttonYellow
                }
            }
            var buttonBgColor: Color {
                if status == .Set {
                    if date <= .now {
                        Color.buttonYellow
                    } else {
                        Color.buttonRed
                    }
                } else {
                    Color.darkGreen
                }
            }
            var buttonIconName: String {
                if status == .Set {
                    if date <= .now {
                        "play.fill"
                    } else {
                        "stop.fill"
                    }
                } else {
                    "play.fill"
                }
            }
            
            var intent: ReminderLAIntent {
                switch status {
                case .NotSet:
                    let intent = ReminderLAIntent()
                    intent.status = "Set"
                    
                    return intent
                case .Set:
                    if context.state.date <= .now {
                        let intent = ReminderLAIntent()
                        intent.status = "OnBreak"
                        
                        return intent
                    } else {
                        let intent = ReminderLAIntent()
                        intent.status = "NotSet"
                        
                        return intent
                    }
                case .OnBreak:
                    let intent = ReminderLAIntent()
                    intent.status = "Set"
                    
                    return intent
                }
            }
            
            var text: String {
                switch status {
                case .NotSet:
                    "Reminder\nnot activated"
                case .Set:
                    if date <= .now {
                        "Time to rest!"
                    } else {
                        "Rest in"
                    }
                case .OnBreak:
                    if date <= .now {
                        "Start Work!"
                    } else {
                        "Start Work in"
                    }
                }
            }
            
            return DynamicIsland {
//                DynamicIslandExpandedRegion(.leading) {
//                    Text("Leading")
//                }
//                DynamicIslandExpandedRegion(.trailing) {
//                    Text("Trailing")
//                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(spacing: 8) {
                        ProgressView(
                            timerInterval: Date.now...date,
                            countsDown: true,
                            label: { EmptyView() },
                            currentValueLabel: { EmptyView() }
                        )
                        .progressViewStyle(.circular)
                        .font(.title)
                        .bold()
                        .tint(progressColor)
                        .frame(width: 50)
                        
                        if (status == .Set && date >= .now) ||
                            (status == .OnBreak && date >= .now) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(text)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                                Text(
                                    timerInterval: Date.now...date,
                                    countsDown: true
                                )
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            }
                        } else {
                            Text(text)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.cream)
                        }
                        
                        Spacer()
                        
                        if !(status == .OnBreak && date >= .now) {
                            StartStopButton(
                                iconName: buttonIconName,
                                bgColor: buttonBgColor,
                                intent: intent
                            )
                        }
                    }
                }
            } compactLeading: {
                ZStack {
                    ProgressView(
                        timerInterval: Date.now...date,
                        countsDown: true,
                        label: { EmptyView() },
                        currentValueLabel: { EmptyView() }
                    )
                    .progressViewStyle(.circular)
                    .font(.title)
                    .bold()
                    .tint(progressColor)
                }
                .frame(width: 35)
            } compactTrailing: {
                Text(
                    timerInterval: Date.now...date,
                    countsDown: true
                )
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .frame(width: 35)
            } minimal: {
                ZStack {
                    ProgressView(
                        timerInterval: Date.now...date,
                        countsDown: true,
                        label: { EmptyView() },
                        currentValueLabel: { EmptyView() }
                    )
                    .progressViewStyle(.circular)
                    .font(.title)
                    .bold()
                    .tint(progressColor)
                }
                .frame(width: 24)
            }
        }
    }
}

#Preview("Reminder", as: .dynamicIsland(.expanded), using: ReminderAttributes.preview) {
   ReminderLiveActivity()
} contentStates: {
    ReminderAttributes.ContentState.set
}
