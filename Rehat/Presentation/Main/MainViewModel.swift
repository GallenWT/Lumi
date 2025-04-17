//
//  MainViewModel.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import Foundation
import Combine
import WidgetKit
import SwiftUI

class MainViewModel: ObservableObject {
    @AppStorage(
        BoardingDefaults.tutorialKey,
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var showTutorial: Bool = true
    
    @AppStorage(
        BoardingDefaults.skipTutorialKey,
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var skippedTutorial: Bool = false
    
    @Published var tutorialSection: TutorialSection = .Welcome
    @Published var showSkipAlert: Bool = false
    @Published var showStartAlert: Bool = false
    @Published var currentSecond: Int = 0
    private var timer: AnyCancellable?
    
    private let reminderWCDelegate = ReminderWCDelegate()
    private let hapticManager = HapticManager.shared
    
    init() {
        reminderWCDelegate.setup(
            onReceiveReminder: { _, _ in
                self.setupTimer()
            }
        )
    }
    
    deinit {
        timer?.cancel()
    }
    
    func onEvent(event: MainEvent) {
        switch event {
        case .StartReminder:
            startReminder()
        case .StartRest:
            startRest()
        case .StopReminder:
            stopReminder()
        case .ResetTimer:
            setupTimer()
        case .ResetTutorial:
            resetTutorial()
        case .ContinueTutorial:
            if let section = TutorialSection(
                rawValue: tutorialSection.rawValue + 1
            ) {
                tutorialSection = section
            }
        case .ToggleStartAlert:
            showStartAlert.toggle()
        case .ToggleSkipAlert:
            showSkipAlert.toggle()
        case .SkipTutorial:
            finishTutorial(skip: true)
        case .FinishTutorial:
            finishTutorial(skip: false)
        }
    }
    
    private func startReminder() {
        DispatchQueue.main.async {
            if self.skippedTutorial {
                self.showStartAlert = true
            }
            
            let reminderDate = Date()
                .advanced(by: 20 * 60)
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(reminderDate, forKey: "date")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(ReminderStatus.Set.rawValue, forKey: "status")
            
            let interval = reminderDate.timeIntervalSince(.now)
            self.currentSecond = 20 * 60
            
            self.startTimer()
            
            ReminderLAManager.shared.start()
            WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
            NotificationManager.setReminderNotifications(
                timeInterval: interval
            )
            
            self.reminderWCDelegate.updateReminder(
                status: .Set,
                date: reminderDate
            )
        }
    }
    
    private func startRest() {
        DispatchQueue.main.async {
            let reminderDate = Date()
                .advanced(by: 20)
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(reminderDate, forKey: "date")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(ReminderStatus.OnBreak.rawValue, forKey: "status")
            
            let interval = reminderDate.timeIntervalSince(.now)
            self.currentSecond = 20
            
            self.startTimer()
            
            ReminderLAManager.shared.update()
            WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
            NotificationManager.cancelReminderNotifications()
            NotificationManager.setRestNotification(
                timeInterval: interval
            )
        }
    }
    
    private func stopReminder() {
        DispatchQueue.main.async {
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(Date(), forKey: "date")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(ReminderStatus.NotSet.rawValue, forKey: "status")
            
            self.currentSecond = 0
            
            self.timer?.cancel()
            
            ReminderLAManager.shared.stop()
            WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
            NotificationManager.cancelReminderNotifications()
            
            self.updateReward()
            
            self.reminderWCDelegate.updateReminder(
                status: .NotSet,
                date: Date()
            )
        }
    }
    
    private func setupTimer() {
        let status = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
        guard let status = status else {
            return
        }
        
        if status != "Set" {
            self.currentSecond = 0
            self.timer?.cancel()
            
            NotificationManager.cancelReminderNotifications()
            
            if status == "NotSet" {
                ReminderLAManager.shared.stop()
                WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
                
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(false, forKey: "onRest")
                
                reminderWCDelegate.updateRest(onRest: false)
            }
            
            return
        }
        
        let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
        guard let date = date as? Date else {
            return
        }
        
        guard date > .now else {
            currentSecond = 0
            
            if !showTutorial {
                hapticManager.playHaptic()
                
                UserDefaults(suiteName: AppGroupManager.suiteName)?
                    .set(true, forKey: "onRest")
                
                reminderWCDelegate.updateRest(onRest: true)
            }
            
            return
        }
        
        currentSecond = Int(date.timeIntervalSince(.now))
        startTimer()
    }
    
    private func startTimer() {
        timer?.cancel()
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.currentSecond -= 1
                
                if self?.currentSecond == 0 && self?.showTutorial == false {
                    self?.hapticManager.playHaptic()
                    
                    UserDefaults(suiteName: AppGroupManager.suiteName)?
                        .set(true, forKey: "onRest")
                    
                    self?.reminderWCDelegate.updateRest(onRest: true)
                }
            }
    }
    
    private func updateReward() {
        DispatchQueue.main.async {
            let currentCurrency = UserDefaults(suiteName: AppGroupManager.suiteName)?
                .integer(forKey: "currency") ?? 0
            let currentCycle = UserDefaults(suiteName: AppGroupManager.suiteName)?
                .integer(forKey: "cycleCount") ?? 0
            
            let newCurrency = currentCurrency + (currentCycle * 10)
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(newCurrency, forKey: "currency")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(currentCycle > 0, forKey: "showReward")
            
            self.reminderWCDelegate.updateCurrency(
                currency: newCurrency
            )
            self.reminderWCDelegate.updateShowReward(
                showReward: currentCycle > 0
            )
        }
    }
    
    private func resetTutorial() {
        if !showTutorial {
            return
        }
        
        DispatchQueue.main.async {
            let status = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
            guard let status = status else {
                return
            }
            
            if status != "NotSet" {
                self.stopReminder()
            }
        }
    }
    
    private func finishTutorial(skip: Bool) {
        DispatchQueue.main.async {
            BoardingDefaults.shared.saveShowTutorial(false)
            BoardingDefaults.shared.saveSkipTutorial(skip)
        }
    }
}
