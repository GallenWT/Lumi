//
//  AppDelegate.swift
//  Rehat
//
//  Created by Darren Thiores on 17/06/24.
//

import Foundation
import SwiftUI

extension RehatApp {
    class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            let nc = UNUserNotificationCenter.current()
            nc.delegate = self
            
            return true
        }
        
        func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
        ) {
            completionHandler([.banner, .list, .badge, .sound])
        }
    }
}
