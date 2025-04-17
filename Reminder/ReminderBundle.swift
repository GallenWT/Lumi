//
//  ReminderBundle.swift
//  Reminder
//
//  Created by Darren Thiores on 18/06/24.
//

import WidgetKit
import SwiftUI

@main
struct ReminderBundle: WidgetBundle {
    var body: some Widget {
        ReminderWidget()
        ReminderLiveActivity()
    }
}
