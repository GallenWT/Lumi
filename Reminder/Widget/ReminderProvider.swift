//
//  ReminderProvider.swift
//  Rehat
//
//  Created by Darren Thiores on 18/06/24.
//

import SwiftUI
import WidgetKit
import os.log

struct ReminderProvider: TimelineProvider {
    typealias Entry = ReminderEntry
    
    func placeholder(in context: Context) -> ReminderEntry {
        Logger().log("Placeholder")
        
        return ReminderEntry(
            date: Date(),
            reminderDate: Date()
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ReminderEntry) -> Void) {
        Logger().log("Snapshot")
        
        let status = getStatus()
        guard let status else {
            completion(
                ReminderEntry(
                    date: Date(),
                    reminderDate: Date()
                )
            )
            
            return
        }
        
        let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
        guard let date = date as? Date else {
            var newDate: Date {
                switch status {
                case .NotSet:
                    return Date()
                case .Set:
                    return Date().advanced(by: 20 * 60)
                case .OnBreak:
                    return Date().advanced(by: 20)
                }
            }
            
            completion(
                ReminderEntry(
                    date: Date(),
                    reminderDate: newDate
                )
            )
            
            return
        }
        
        completion(
            ReminderEntry(
                date: Date(),
                reminderDate: date
            )
        )
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ReminderEntry>) -> Void) {
        let status = getStatus()
        guard let status, status != .NotSet else {
            completion(
                Timeline(
                    entries: [
                        ReminderEntry(
                            date: Date(),
                            reminderDate: Date()
                        )
                    ],
                    policy: .atEnd
                )
            )
            
            return
        }
        
        let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
        var newDate: Date = Date()
        
        if let date = date as? Date {
            newDate = date
        } else {
            switch status {
            case .NotSet:
                newDate = Date()
            case .Set:
                newDate = Date().advanced(by: 20 * 60)
            case .OnBreak:
                newDate = Date().advanced(by: 20)
            }
        }
        
        var entries: [ReminderEntry] = []
        
        entries.append(
            ReminderEntry(
                date: Date(),
                reminderDate: newDate
            )
        )
        
        if status == .Set || status == .OnBreak{
            entries.append(
                ReminderEntry(
                    date: newDate,
                    reminderDate: newDate
                )
            )
        }
        
//        for i in 1...70 {
//            let isOdd = (i % 2) != 0
//            let currentlySet = status == .Set
//            
//            var entryDate: Date {
//                var advanceSecond: Double {
//                    var restCount: Int {
//                        if isOdd {
//                            return currentlySet ? (i/2 + 1) : i/2
//                        }
//                        
//                        return currentlySet ? i/2 : (i/2 + 1)
//                    }
//                    var workCount: Int {
//                        if isOdd {
//                            return currentlySet ? i/2 : (i/2 + 1)
//                        }
//                        
//                        return currentlySet ? (i/2 + 1) : i/2
//                    }
//                    
//                    let restSecond = restCount * 20
//                    let workSecond = workCount * 20 * 60
//                    
//                    return Double(restSecond + workSecond)
//                }
//                
//                return newDate.advanced(by: advanceSecond)
//            }
//            
//            var reminderDate: Date {
//                if isOdd {
//                    return currentlySet ? entryDate.advanced(by: 20) : entryDate.advanced(by: 20 * 60)
//                }
//                
//                return currentlySet ? entryDate.advanced(by: 20 * 60) : entryDate.advanced(by: 20)
//            }
//            
//            var entryStatus: ReminderStatus {
//                if isOdd {
//                    return currentlySet ? .OnBreak : .Set
//                }
//                
//                return currentlySet ? .Set : .OnBreak
//            }
//            
//            entries.append(
//                ReminderEntry(
//                    date: entryDate,
//                    reminderDate: reminderDate,
//                    status: entryStatus
//                )
//            )
//        }
        
        completion(
            Timeline(entries: entries, policy: .atEnd)
        )
    }
    
    private func getStatus() -> ReminderStatus? {
        let stringStatus = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
        guard let stringStatus else {
            return nil
        }
        
        return ReminderStatus(rawValue: stringStatus)
    }
}
