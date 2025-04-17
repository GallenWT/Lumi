//
//  ButtonStyle.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

enum ReminderType{
    case startReminder
    case stopReminder
    case endReminder
    
    var textReminder : String{
        switch self {
        case .startReminder :
            return "Start Reminder"
        case .stopReminder :
            return "Stop Reminder"
        case .endReminder :
            return ""
        }
    }
    
    var textColor : Color {
        switch self {
        case .startReminder :
            return Color(hex: "155948")
        case .stopReminder :
            return Color(hex: "155948")
        case .endReminder :
            return Color(hex: "155948")
        }
    }
    var backgroundColor : Color {
        switch self {
        case .startReminder :
            return Color(hex: "F0C958")
        case .stopReminder :
            return Color(hex: "FFA57E")
        case .endReminder:
            return Color(hex: "FFA57E")
        }
    }
}


