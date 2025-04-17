//
//  RehatApp.swift
//  Rehat
//
//  Created by Darren Thiores on 12/06/24.
//

import SwiftUI
import WidgetKit
import ActivityKit
import BackgroundTasks
import os.log
import CoreData

@main
struct RehatApp: App {
    @StateObject private var appVM = AppViewModel()
    
    init() {
        WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !appVM.notificationAllowed {
                    WelcomeView()
                }
                else if appVM.showBoarding {
                    TwentyView()
                }
                else if appVM.showTutorial {
                    MainView()
                }
                else if appVM.onRest {
                    RestView()
                }
                else if appVM.showReward {
                    RewardView()
                }
                else {
                    MainView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
        }
        .backgroundTask(.appRefresh("refreshReminder")) {
            print("here refreshed")
            Logger().log("refreshed here")
            
            let stringStatus = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
            guard let stringStatus else {
                return
            }
            
            let status = ReminderStatus(rawValue: stringStatus)
            guard let status, status != .NotSet else {
                ReminderLAManager.shared.stop()
                return
            }
            
            if status == .Set {
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set("OnBreak", forKey: "status")
                
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(Date().advanced(by: 20), forKey: "date")
            }
            
            if status == .OnBreak {
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set("Set", forKey: "status")
                
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(Date().advanced(by: 20*60), forKey: "date")
            }
            
            if Activity<ReminderAttributes>.activities.isEmpty {
                ReminderLAManager.shared.start()
            } else {
                ReminderLAManager.shared.update()
            }
        }
    }
}
