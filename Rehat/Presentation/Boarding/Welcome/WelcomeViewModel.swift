//
//  WelcomeViewModel.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    
    func onEvent(event: WelcomeEvent) {
        switch event {
        case .AllowNotification:
            NotificationManager.requestAuthorization { _, error in
                BoardingDefaults
                    .shared
                    .saveNotificationAllowance(true)
                
                if let error = error {
                    print(error)
                }
            }
        case .CheckStatus:
            NotificationManager.getAuthorizationStatus { authorized in
                BoardingDefaults
                    .shared
                    .saveNotificationAllowance(authorized)
            }
        }
    }
    
}
