//
//  RestViewModel.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import Foundation
import Combine
import WidgetKit
import ActivityKit

class RestViewModel: ObservableObject {
    @Published var currentSecond: Int = 0
    @Published var currentSection: RestSection = .StartSection
    
    private var timer: AnyCancellable?
    private var loadTimer: AnyCancellable?
    private var loadSecond: Int = 0
    
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
        loadTimer?.cancel()
    }
    
    func onEvent(event: RestEvent) {
        switch event {
        case .StartRest:
            loadRest()
        case .UpdateTimer:
            setupTimer()
        case .Reload:
            loadRest()
        }
    }
    
    private func loadRest() {
        DispatchQueue.main.async {
            self.hapticManager.playHaptic()
            
            self.currentSection = .LoadSection
            
            self.loadTimer?.cancel()
            self.loadTimer = Timer
                .publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.loadSecond += 1
                    
                    if self?.loadSecond == 3 {
                        self?.currentSection = .OnRestSection
                        self?.startRest()
                        
                        self?.loadTimer?.cancel()
                    }
                }
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
            
            if Activity<ReminderAttributes>.activities.isEmpty {
                ReminderLAManager.shared.start()
            } else {
                ReminderLAManager.shared.update()
            }
            
            WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
            NotificationManager.cancelReminderNotifications()
            NotificationManager.setRestNotification(
                timeInterval: interval
            )
            
            self.reminderWCDelegate.updateReminder(
                status: .OnBreak,
                date: reminderDate
            )
        }
    }
    
    private func setupTimer() {
        let status = UserDefaults(suiteName: AppGroupManager.suiteName)?.string(forKey: "status")
        guard let status = status else {
            return
        }
        
        if status != "OnBreak" {
            return
        }
        
        let date = UserDefaults(suiteName: AppGroupManager.suiteName)?.object(forKey: "date")
        guard let date = date as? Date else {
            return
        }
        
        guard date > .now else {
            updateStatus()
            return
        }
        
        self.currentSection = .OnRestSection
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
                
                if self?.currentSecond == 0 {
                    self?.updateStatus()
                }
            }
    }
    
    private func updateStatus() {
        DispatchQueue.main.async {
            self.hapticManager.playHaptic()
            
            let reminderDate = Date()
                .advanced(by: 20 * 60)
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(reminderDate, forKey: "date")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(ReminderStatus.Set.rawValue, forKey: "status")
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(false, forKey: "onRest")
            
            self.updateCycle()
            
            if Activity<ReminderAttributes>.activities.isEmpty {
                ReminderLAManager.shared.start()
            } else {
                ReminderLAManager.shared.update()
            }
            
            WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
            let interval = reminderDate.timeIntervalSince(.now)
            
            NotificationManager.setReminderNotifications(
                timeInterval: interval
            )
            
            self.reminderWCDelegate.updateReminder(
                status: .Set,
                date: reminderDate
            )
        }
    }
    
    private func updateCycle() {
        DispatchQueue.main.async {
            let currentCycle = UserDefaults(suiteName: AppGroupManager.suiteName)?
                .integer(forKey: "cycleCount") ?? 0
            
            UserDefaults(suiteName: AppGroupManager.suiteName)?
                .set(currentCycle + 1, forKey: "cycleCount")
            
            self.reminderWCDelegate.updateCycle(
                cycleCount: currentCycle + 1
            )
        }
    }
}
