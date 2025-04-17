//
//  AppViewModel.swift
//  Lumi Watch App
//
//  Created by Darren Thiores on 24/06/24.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    @AppStorage("onRest") var onRest: Bool = false
    
    @AppStorage("showReward") var showReward: Bool = false
}
