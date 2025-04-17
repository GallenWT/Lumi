//
//  ReminderAttributesExtension.swift
//  Rehat
//
//  Created by Darren Thiores on 19/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

extension ReminderAttributes {
    static var preview: ReminderAttributes {
        ReminderAttributes(description: "This is a test")
    }
}

extension ReminderAttributes.ContentState {
    static var notSet: ReminderAttributes.ContentState {
        ReminderAttributes.ContentState(
            date: Date(),
            status: .NotSet
        )
     }
     
    static var set: ReminderAttributes.ContentState {
         ReminderAttributes.ContentState(
            date: Date().advanced(by: 20 * 60),
            status: .Set
         )
     }
}
