//
//  TwentyViewModel.swift
//  Rehat
//
//  Created by Darren Thiores on 22/06/24.
//

import Foundation

class TwentyViewModel: ObservableObject {
    
    func onEvent(event: TwentyEvent) {
        switch event {
        case .Continue:
            BoardingDefaults
                .shared
                .saveShowBoarding(false)
        }
    }
    
}
