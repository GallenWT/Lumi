//
//  HomeViewModel.swift
//  Lumi Watch App
//
//  Created by Darren Thiores on 24/06/24.
//

import Foundation
import Combine
import WidgetKit
import SwiftUI

class HomeViewModel: ObservableObject {
    @AppStorage("status") var statusString: String = "NotSet"
    var status: ReminderStatus {
        return ReminderStatus(rawValue: statusString) ?? .NotSet
    }
    
    @Published var currentSecond: Int = 0
    private var timer: AnyCancellable?
    
    private let reminderWCDelegate = ReminderWCDelegate()
    private let reminderDefaults = ReminderDefaults.shared
    
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
    
    func onEvent(event: HomeEvent) {
        switch event {
        case .StartReminder:
            startReminder()
        case .StartRest:
            startRest()
        case .StopReminder:
            stopReminder()
        case .ResetTimer:
            setupTimer()
        }
    }
    
    private func startReminder() {
        DispatchQueue.main.async {
            let reminderDate = Date()
                .advanced(by: 20 * 60)
            
            self.reminderDefaults
                .saveDate(reminderDate)
            self.reminderDefaults
                .saveStatus(ReminderStatus.Set.rawValue)
            
            let interval = reminderDate.timeIntervalSince(.now)
            self.currentSecond = 20 * 60
            
            self.startTimer()
            
            // ReminderLAManager.shared.start()
            // WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
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
            
            self.reminderDefaults
                .saveDate(reminderDate)
            self.reminderDefaults
                .saveStatus(ReminderStatus.OnBreak.rawValue)
            
            let interval = reminderDate.timeIntervalSince(.now)
            self.currentSecond = 20
            
            self.startTimer()
            
            // ReminderLAManager.shared.update()
            // WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
             NotificationManager.cancelReminderNotifications()
            NotificationManager.setRestNotification(
                timeInterval: interval
            )
        }
    }
    
    private func stopReminder() {
        DispatchQueue.main.async {
            self.reminderDefaults
                .saveDate(Date())
            self.reminderDefaults
                .saveStatus(ReminderStatus.NotSet.rawValue)
            
            self.currentSecond = 0
            
            self.timer?.cancel()
            
            //ReminderLAManager.shared.stop()
            //WidgetCenter.shared.reloadTimelines(ofKind: "Reminder")
            
             NotificationManager.cancelReminderNotifications()
            
            self.updateReward()
            
            self.reminderWCDelegate.updateReminder(
                status: .NotSet,
                date: Date()
            )
        }
    }
    
    private func setupTimer() {
        let status = reminderDefaults.loadStatus()
        
        if status != .Set {
            self.currentSecond = 0
            self.timer?.cancel()
            
            if status == .NotSet {
                reminderDefaults
                    .saveOnRest(false)
                
                reminderWCDelegate.updateRest(onRest: false)
            }
            
            return
        }
        
        let date = reminderDefaults.loadDate()
        
        guard date > .now else {
            currentSecond = 0
            
            reminderDefaults
                .saveOnRest(true)
            
            reminderWCDelegate.updateRest(onRest: true)
            
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
                
                if self?.currentSecond == 0 {
                    self?.reminderDefaults
                        .saveOnRest(true)
                    
                    self?.reminderWCDelegate.updateRest(onRest: true)
                }
            }
    }
    
    private func updateReward() {
        DispatchQueue.main.async {
            let currentCurrency = self.reminderDefaults.loadCurrency()
            let currentCycle = self.reminderDefaults.loadCycleCount()
            
            let newCurrency = currentCurrency + (currentCycle * 10)
            
            self.reminderDefaults
                .saveCurrency(newCurrency)
            self.reminderDefaults
                .saveShowReward(currentCycle > 0)
            
            self.reminderWCDelegate.updateCurrency(
                currency: currentCycle * 10
            )
            self.reminderWCDelegate.updateShowReward(
                showReward: currentCycle > 0
            )
        }
    }
}
