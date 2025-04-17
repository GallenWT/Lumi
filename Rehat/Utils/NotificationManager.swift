//
//  NotificationManager.swift
//  Rehat
//
//  Created by Darren Thiores on 17/06/24.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    private init() { }
    
    static func requestAuthorization(
        _ completion: @escaping (Bool, Error?) -> Void
    ) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { success, error in
                completion(success, error)
            }
    }
    
    static func getAuthorizationStatus(_ completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            let authorized = settings.authorizationStatus == .authorized
            completion(authorized)
        }
    }
    
    static func setReminderNotifications(
        timeInterval: TimeInterval
    ) {
        let center = UNUserNotificationCenter
            .current()
        
        center.removeDeliveredNotifications(withIdentifiers: reminderIdentifiers)
        center.removePendingNotificationRequests(withIdentifiers: reminderIdentifiers)
        
        for (i, reminderIdentifier) in reminderIdentifiers.enumerated() {
            let content = UNMutableNotificationContent()
            content.title = reminderTitle(index: i)
            content.body = reminderContent(index: i)
            
            #if os(iOS)
            content.sound = .defaultRingtone
            #else
            content.sound = .default
            #endif
            
            content.interruptionLevel = .timeSensitive
            
            let twentyMinutes: Double = 20 * 60
            let advancedTime = twentyMinutes * Double(i)
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInterval.advanced(by: advancedTime),
                repeats: false
            )
            
            let request = UNNotificationRequest(
                identifier: reminderIdentifier,
                content: content,
                trigger: trigger
            )
            
            center.add(request) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func cancelReminderNotifications() {
        let center = UNUserNotificationCenter
            .current()
        
        center
            .removeDeliveredNotifications(withIdentifiers: reminderIdentifiers)
        
        center
            .removePendingNotificationRequests(withIdentifiers: reminderIdentifiers)
    }
    
    static func setRestNotification(
        timeInterval: TimeInterval
    ) {
        let center = UNUserNotificationCenter
            .current()
        
        center.removeDeliveredNotifications(withIdentifiers: [restIdentifier])
        center.removePendingNotificationRequests(withIdentifiers: [restIdentifier])
        
        let content = UNMutableNotificationContent()
        content.title = "Rest done!"
        content.body = "Let's get back to work!"
        
        #if os(iOS)
        content.sound = .defaultRingtone
        #else
        content.sound = .default
        #endif
        
        content.interruptionLevel = .timeSensitive
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInterval,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: restIdentifier,
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func clearNotifications() {
        let center = UNUserNotificationCenter
            .current()
        
        center.removeAllDeliveredNotifications()
    }
    
    fileprivate static func reminderTitle(index: Int) -> String {
        if index == 1 || index == 2 {
            return "⁠Time for your rest!"
        }
        
        return "Rest now!"
    }
    
    fileprivate static func reminderContent(index: Int) -> String {
        switch index {
        case 0:
            return "It's been 20 minutes! Now is the optimal time to rest your eyes."
        case 1:
            return "It's been 40 minutes since your last rest! Resting your eyes will reduce eye fatigue."
        case 2:
            return "It's been 60 minutes since your last rest! Rest your eyes to refresh them."
        default:
            return "It’s been over an hour since your last rest. Rest your eyes to reduce strain."
        }
    }
    
    fileprivate static let reminderIdentifiers: [String] = (1...63).map { i in "ReminderNotification-\(i)"}
    fileprivate static let restIdentifier = "RestNotification"
}
