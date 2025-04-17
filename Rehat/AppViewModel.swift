//
//  AppViewModel.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    @AppStorage(
        "onRest",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var onRest: Bool = false
    
    @AppStorage(
        "showReward",
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var showReward: Bool = false
    
    @AppStorage(
        BoardingDefaults.boardingKey,
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var showBoarding: Bool = true
    
    @AppStorage(
        BoardingDefaults.notificationKey,
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var notificationAllowed: Bool = false
    
    @AppStorage(
        BoardingDefaults.tutorialKey,
        store: UserDefaults(suiteName: AppGroupManager.suiteName)
    ) var showTutorial: Bool = true
}
