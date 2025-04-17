//
//  LumiApp.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

@main
struct Lumi_Watch_AppApp: App {
    
    init() {
        NotificationManager.requestAuthorization { success, error in
            if success {
                print("success")
            } else {
                if let error = error {
                    print("error: \(error)")
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
