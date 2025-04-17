//
//  ReminderIntent.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import WidgetKit
import AppIntents
import os.log

struct ReminderIntent: AppIntent {
    static var title: LocalizedStringResource = "Switch Reminder Status Intent"
    
    @Parameter(title: "Status", default: "NotSet")
    var status: String
    
    func perform() async throws -> some IntentResult {
        UserDefaults(suiteName: AppGroupManager.suiteName)?.set(status, forKey: "status")
        
        var advanceTime: Int {
            switch status {
            case "Set":
                return 20 * 60
            case "OnBreak":
                return 20
            default:
                return 0
            }
        }
        
        let date = Date().advanced(by: Double(advanceTime))
        
        UserDefaults(suiteName: AppGroupManager.suiteName)?.set(
            date,
            forKey: "date"
        )
        
        WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
        
        if status == "NotSet" {
            let currentCurrency = UserDefaults(suiteName: AppGroupManager.suiteName)?
                .integer(forKey: "currency") ?? 0
            let currentCycle = UserDefaults(suiteName: AppGroupManager.suiteName)?
                .integer(forKey: "cycleCount") ?? 0
            
            let newCurrency = currentCurrency + (currentCycle * 10)
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(newCurrency, forKey: "currency")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(currentCycle > 0, forKey: "showReward")
            
            NotificationManager.cancelReminderNotifications()
        }
        
        if status == "OnBreak" {
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(true, forKey: "onRest")
            
            NotificationManager.cancelReminderNotifications()
            NotificationManager.setRestNotification(
                timeInterval: date.timeIntervalSince(.now)
            )
        }
        
        if status == "Set" {
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(false, forKey: "onRest")
            
            NotificationManager.setReminderNotifications(
                timeInterval: date.timeIntervalSince(.now)
            )
        }
        
        ReminderTask.scheduleAppRefresh()
        
        return .result()
    }
    
}
