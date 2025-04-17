//
//  ReminderLAManager.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import Foundation
import ActivityKit
import WidgetKit
import os.log

class ReminderLAManager {
    static let shared = ReminderLAManager()
    
    private init() { }
    
    func start() {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            let stringStatus = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
            guard let stringStatus else {
                return
            }
            
            let status = ReminderStatus(rawValue: stringStatus)
            guard let status else {
                return
            }
            
            let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
            guard let date = date as? Date else {
                return
            }
            
            do {
                let reminder = ReminderAttributes(description: "sabach")
                let initialState = ReminderAttributes.ContentState(
                    date: date,
                    status: status
                )
                
                let activity = try Activity.request(
                    attributes: reminder,
                    content: .init(state: initialState, staleDate: nil),
                    pushType: .token
                )
            } catch {
                Logger().log("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func update() {
        Task {
            let stringStatus = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
            guard let stringStatus else {
                return
            }
            
            let status = ReminderStatus(rawValue: stringStatus)
            guard let status else {
                return
            }
            
            let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
            guard let date = date as? Date else {
                return
            }
            
            let contentState: ReminderAttributes.ContentState
            contentState = ReminderAttributes.ContentState(
                date: date,
                status: status
            )
            
            for activity in Activity<ReminderAttributes>.activities {
                await activity.update(
                    ActivityContent<ReminderAttributes.ContentState>(
                        state: contentState,
                        staleDate: Date.now,
                        relevanceScore: 100
                    )
                )
            }
        }
    }
    
    func stop() {
        Task {
            let finalContent = ReminderAttributes.ContentState(
                date: Date(),
                status: .NotSet
            )
            
            for activity in Activity<ReminderAttributes>.activities {
                await activity.end(
                    ActivityContent(state: finalContent, staleDate: nil),
                    dismissalPolicy: .immediate
                )
                
                print ("Cancelled Reminder Live Activity")
            }
        }
    }
}
