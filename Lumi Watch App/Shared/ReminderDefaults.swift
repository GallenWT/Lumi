//
//  ReminderDefaults.swift
//  Lumi Watch App
//
//  Created by Darren Thiores on 24/06/24.
//

import Foundation

protocol ReminderDefaultsDelegate {
    func loadStatus() -> ReminderStatus
    func saveStatus(_ status: String)
    func loadDate() -> Date
    func saveDate(_ date: Date)
    func loadOnRest() -> Bool
    func saveOnRest(_ onRest: Bool)
    func loadCycleCount() -> Int
    func saveCycleCount(_ cycleCount: Int)
    func loadCurrency() -> Int
    func saveCurrency(_ currency: Int)
    func loadShowReward() -> Bool
    func saveShowReward(_ showReward: Bool)
}

class ReminderDefaults: ReminderDefaultsDelegate {
    static let shared = ReminderDefaults()
    
    private init() { }
    
    func loadStatus() -> ReminderStatus {
        let statusString: String = load(ReminderDefaults.statusKey) ?? "NotSet"
        let status = ReminderStatus(rawValue: statusString) ?? .NotSet
        
        return status
    }
    
    func saveStatus(_ status: String) {
        save(status, key: ReminderDefaults.statusKey)
    }
    
    func loadDate() -> Date {
        return load(ReminderDefaults.dateKey) ?? .now
    }
    
    func saveDate(_ date: Date) {
        save(date, key: ReminderDefaults.dateKey)
    }
    
    func loadOnRest() -> Bool {
        return load(ReminderDefaults.onRestKey) ?? false
    }
    
    func saveOnRest(_ onRest: Bool) {
        save(onRest, key: ReminderDefaults.onRestKey)
    }
    
    func loadCycleCount() -> Int {
        return load(ReminderDefaults.cycleCountKey) ?? 0
    }
    
    func saveCycleCount(_ cycleCount: Int) {
        save(cycleCount, key: ReminderDefaults.cycleCountKey)
    }
    
    func loadCurrency() -> Int {
        return load(ReminderDefaults.currencyKey) ?? 0
    }
    
    func saveCurrency(_ currency: Int) {
        save(currency, key: ReminderDefaults.currencyKey)
    }
    
    func loadShowReward() -> Bool {
        return load(ReminderDefaults.showRewardKey) ?? false
    }
    
    func saveShowReward(_ showReward: Bool) {
        save(showReward, key: ReminderDefaults.showRewardKey)
    }
    
    private func load<T>(_ key: String) -> T? {
        return UserDefaults()
            .value(forKey: key) as? T
    }
    
    private func save<T>(_ value: T, key: String) {
        UserDefaults()
            .set(value, forKey: key)
    }
    
    static let statusKey: String = "status"
    static let dateKey: String = "date"
    static let onRestKey: String = "onRest"
    static let cycleCountKey: String = "cycleCount"
    static let currencyKey: String = "currency"
    static let showRewardKey: String = "showReward"
}
