//
//  BoardingDefaults.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import Foundation

protocol BoardingDefaultsDelegate {
    func loadNotificationAllowance() -> Bool
    func saveNotificationAllowance(_ allowed: Bool)
    func loadShowBoarding() -> Bool
    func saveShowBoarding(_ showBoarding: Bool)
    func loadShowTutorial() -> Bool
    func saveShowTutorial(_ showTutorial: Bool)
    func loadSkipTutorial() -> Bool
    func saveSkipTutorial(_ skipTutorial: Bool)
}

class BoardingDefaults: BoardingDefaultsDelegate {
    static let shared = BoardingDefaults()
    
    private init() { }
    
    func loadNotificationAllowance() -> Bool {
        return load(BoardingDefaults.notificationKey) ?? false
    }
    
    func saveNotificationAllowance(_ allowed: Bool) {
        save(allowed, key: BoardingDefaults.notificationKey)
    }
    
    func loadShowBoarding() -> Bool {
        return load(BoardingDefaults.boardingKey) ?? true
    }
    
    func saveShowBoarding(_ showBoarding: Bool) {
        save(showBoarding, key: BoardingDefaults.boardingKey)
    }
    
    func loadShowTutorial() -> Bool {
        return load(BoardingDefaults.tutorialKey) ?? true
    }
    
    func saveShowTutorial(_ showTutorial: Bool) {
        save(showTutorial, key: BoardingDefaults.tutorialKey)
    }
    
    func loadSkipTutorial() -> Bool {
        return load(BoardingDefaults.skipTutorialKey) ?? true
    }
    
    func saveSkipTutorial(_ skipTutorial: Bool) {
        save(skipTutorial, key: BoardingDefaults.skipTutorialKey)
    }
    
    private func load<T>(_ key: String) -> T? {
        return UserDefaults(suiteName: AppGroupManager.suiteName)?
            .value(forKey: key) as? T
    }
    
    private func save<T>(_ value: T, key: String) {
        UserDefaults(suiteName: AppGroupManager.suiteName)?
            .set(value, forKey: key)
    }
    
    static let notificationKey: String = "notificationAllowed"
    static let boardingKey: String = "showBoarding"
    static let tutorialKey: String = "showTutorial"
    static let skipTutorialKey: String = "skipTutorial"
}
