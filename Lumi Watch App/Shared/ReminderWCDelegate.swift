//
//  ReminderWCDelegate.swift
//  Lumi Watch App
//
//  Created by Darren Thiores on 24/06/24.
//

import Foundation
import WatchConnectivity

class ReminderWCDelegate: NSObject, WCSessionDelegate {
    private let reminderDefaults = ReminderDefaults.shared
    
    var session: WCSession?
    private var onReceiveReminder: (String, Date) -> Void = { _, _ in }
    private var onReceiveRest: () -> Void = { }
    private var onReceiveCycle: () -> Void = { }
    private var onReceiveCurrency: () -> Void = { }
    private var onReceiveShowReward: () -> Void = { }
    
    func setup(
        onReceiveReminder: @escaping (String, Date) -> Void = { _, _ in },
        onReceiveRest: @escaping () -> Void = {},
        onReceiveCycle: @escaping () -> Void = {},
        onReceiveCurrency: @escaping () -> Void = {},
        onReceiveShowReward: @escaping () -> Void = {}
    ) {
        self.onReceiveReminder = onReceiveReminder
        self.onReceiveRest = onReceiveRest
        self.onReceiveCycle = onReceiveCycle
        self.onReceiveCurrency = onReceiveCurrency
        self.onReceiveShowReward = onReceiveShowReward
        
        session = .default
        session?.delegate = self
        session?.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        let applicationContext = session.applicationContext
        
        DispatchQueue.main.async {
            if let status = applicationContext["status"] as? String, let date = applicationContext["date"] as? Date {
                print("context status: " + status)
                print("context date: \(date)")
                
                self.reminderDefaults.saveStatus(status)
                self.reminderDefaults.saveDate(date)
                
                self.onReceiveReminder(
                    status, date
                )
            }
            
            if let onRest = applicationContext["onRest"] as? Bool {
                print("context on rest: \(onRest)")
                
                self.reminderDefaults.saveOnRest(onRest)
            }
            
            if let cycleCount = applicationContext["cycleCount"] as? Int {
                print("context cycle: \(cycleCount)")
                
                let currentCycleCount = self.reminderDefaults.loadCycleCount()
                
                if cycleCount > currentCycleCount {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
                
                if cycleCount == 0 {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
            }
            
            if let currency = applicationContext["currency"] as? Int {
                print("context currency: \(currency)")
                
                let currentCurrency = self.reminderDefaults.loadCurrency()
                
                if currency > currentCurrency {
                    self.reminderDefaults.saveCurrency(currency)
                }
            }
            
            if let showReward = applicationContext["showReward"] as? Bool {
                print("context show reward: \(showReward)")
                
                self.reminderDefaults.saveShowReward(showReward)
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let status = message["status"] as? String, let date = message["date"] as? Date {
                print("message status: " + status)
                print("message date: \(date)")
                
                self.reminderDefaults.saveStatus(status)
                self.reminderDefaults.saveDate(date)
                
                self.onReceiveReminder(
                    status, date
                )
            }
            
            if let onRest = message["onRest"] as? Bool {
                print("message on rest: \(onRest)")
                
                self.reminderDefaults.saveOnRest(onRest)
            }
            
            if let cycleCount = message["cycleCount"] as? Int {
                print("message cycle: \(cycleCount)")
                
                let currentCycleCount = self.reminderDefaults.loadCycleCount()
                
                if cycleCount > currentCycleCount {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
                
                if cycleCount == 0 {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
            }
            
            if let currency = message["currency"] as? Int {
                print("message currency: \(currency)")
                
                let currentCurrency = self.reminderDefaults.loadCurrency()
                
                if currency > currentCurrency {
                    self.reminderDefaults.saveCurrency(currency)
                }
            }
            
            if let showReward = message["showReward"] as? Bool {
                print("message show reward: \(showReward)")
                
                self.reminderDefaults.saveShowReward(showReward)
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            if let status = applicationContext["status"] as? String, let date = applicationContext["date"] as? Date {
                print("context status: " + status)
                print("context date: \(date)")
                
                self.reminderDefaults.saveStatus(status)
                self.reminderDefaults.saveDate(date)
                
                self.onReceiveReminder(
                    status, date
                )
            }
            
            if let onRest = applicationContext["onRest"] as? Bool {
                print("context on rest: \(onRest)")
                
                self.reminderDefaults.saveOnRest(onRest)
            }
            
            if let cycleCount = applicationContext["cycleCount"] as? Int {
                print("context cycle: \(cycleCount)")
                
                let currentCycleCount = self.reminderDefaults.loadCycleCount()
                
                if cycleCount > currentCycleCount {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
                
                if cycleCount == 0 {
                    self.reminderDefaults.saveCycleCount(cycleCount)
                }
            }
            
            if let currency = applicationContext["currency"] as? Int {
                print("context currency: \(currency)")
                
                let currentCurrency = self.reminderDefaults.loadCurrency()
                
                if currency > currentCurrency {
                    self.reminderDefaults.saveCurrency(currency)
                }
            }
            
            if let showReward = applicationContext["showReward"] as? Bool {
                print("context show reward: \(showReward)")
                
                self.reminderDefaults.saveShowReward(showReward)
            }
        }
    }
    
    func updateReminder(
        status: ReminderStatus,
        date: Date
    ) {
        let message: [String: Any] = [
            "status": status.rawValue,
            "date": date
        ]
        
        send(message)
    }
    
    func updateRest(onRest: Bool) {
        let message: [String: Any] = [
            "onRest": onRest
        ]
        
        send(message)
    }
    
    func updateCycle(cycleCount: Int) {
        let message: [String: Any] = [
            "cycleCount": cycleCount
        ]
        
        send(message)
    }
    
    func updateCurrency(currency: Int) {
        let message: [String: Any] = [
            "currency": currency
        ]
        
        send(message)
    }
    
    func updateShowReward(
        showReward: Bool
    ) {
        let message: [String: Any] = [
            "showReward": showReward
        ]
        
        send(message)
    }
    
    private func send(_ message: [String: Any]) {
        if session?.isReachable == true {
            session?.sendMessage(message, replyHandler: nil) { error in
                print(error.localizedDescription)
            }
        } else {
            do {
                try session?.updateApplicationContext(message)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
