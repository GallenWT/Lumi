//
//  ReminderWidget.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import WidgetKit
import SwiftUI

struct ReminderEntryView: View {
    let entry: ReminderProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @AppStorage(
        "status",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    )
    var status: String = "Not Set"
    var reminderStatus: ReminderStatus {
        return ReminderStatus(rawValue: status) ?? .NotSet
    }
    var date: Date {
        entry.reminderDate
    }
    
    private var text: String {
        switch reminderStatus {
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
    
    private var buttonText: String {
        switch reminderStatus {
        case .NotSet:
            "Start Reminder"
        case .Set:
            if date <= .now {
                "Begin Rest"
            } else {
                "Stop Reminder"
            }
        case .OnBreak:
            if date <= .now {
                "Start Reminder"
            } else {
                ""
            }
        }
    }
    
    private var bgColor: Color {
        switch reminderStatus {
        case .NotSet:
                .softYellow
        case .Set:
            if date <= .now {
                .softGreen
            } else {
                .softRed
            }
        case .OnBreak:
                .softYellow
        }
    }
    
    private var intent: ReminderLAIntent {
        switch reminderStatus {
        case .NotSet:
            let intent = ReminderLAIntent()
            intent.status = "Set"
            
            return intent
        case .Set:
            if entry.reminderDate <= .now {
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
    
    private var imageName: String {
        switch reminderStatus {
        case .NotSet:
            if family == .systemMedium {
                "MediumNotSet"
            } else {
                "SmallLargeNotSet"
            }
        case .Set:
            if family == .systemMedium {
                "MediumSet"
            } else {
                "SmallLargeSet"
            }
        case .OnBreak:
            if family == .systemMedium {
                "MediumSet"
            } else {
                "SmallLargeSet"
            }
        }
    }
    
    private var smallAssetName: String {
        switch reminderStatus {
        case .NotSet:
            "play.fill"
        case .Set:
            if date >= .now {
                "stop.fill"
            } else {
                "ClosedEye"
            }
        case .OnBreak:
            "play.fill"
        }
    }
    
    var body: some View {
        ZStack {
            switch family {
            case .systemLarge:
                ReminderLargeView(
                    status: reminderStatus,
                    text: text,
                    buttonText: buttonText,
                    bgColor: bgColor,
                    date: entry.reminderDate,
                    intent: intent
                )
            case .systemMedium:
                ReminderMediumView(
                    status: reminderStatus,
                    text: text,
                    buttonText: buttonText,
                    bgColor: bgColor,
                    date: entry.reminderDate,
                    intent: intent
                )
            default:
                ReminderSmallView(
                    status: reminderStatus,
                    text: text,
                    assetName: smallAssetName,
                    bgColor: bgColor,
                    date: entry.reminderDate,
                    intent: intent
                )
            }
        }
        .containerBackground(
            for: .widget,
            content: {
                ZStack {
                    Color.clear
                }
                .background(
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
                .overlay {
                    ContainerRelativeShape()
                        .stroke(
                            .textGreen,
                            lineWidth: 3
                        )
                }
            }
        )
    }
}

struct ReminderWidget: Widget {
    let kind: String = "Reminder"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: ReminderProvider()
        ) { entry in
            ReminderEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview(as: .systemSmall) {
    ReminderWidget()
} timeline: {
    ReminderEntry(date: Date(), reminderDate: Date().advanced(by: 20))
    ReminderEntry(date: Date().advanced(by: 20), reminderDate: Date().advanced(by: 20*60))
}
