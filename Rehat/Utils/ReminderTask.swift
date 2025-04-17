//
//  ReminderTask.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import Foundation
import BackgroundTasks

class ReminderTask {
    static let shared = ReminderTask()
    
    private init() { }
    
    static func scheduleAppRefresh() {
        print("app refresh scheduled")
        
        let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
        guard let date = date as? Date else {
            return
        }
        
        let request = BGAppRefreshTaskRequest(identifier: "refreshReminder")
        request.earliestBeginDate = date
        try? BGTaskScheduler.shared.submit(request)
    }
}
