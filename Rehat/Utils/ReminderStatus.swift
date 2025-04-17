//
//  ReminderStatus.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import Foundation

enum ReminderStatus: String, Codable {
    case NotSet
    case Set
    case OnBreak
}

extension ReminderStatus {
    func buttonText() -> String {
        switch self {
        case .NotSet:
            return "Start Reminder"
        default:
            return "Stop Reminder"
        }
    }
}
