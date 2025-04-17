//
//  ReminderAttributes.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ReminderAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var date: Date
        var status: ReminderStatus
    }

    var description: String
}
