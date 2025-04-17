//
//  ContentView.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appVM = AppViewModel()
    
    var body: some View {
        NavigationStack {
            if appVM.onRest {
                RestView()
            }
            else if appVM.showReward {
                Reward()
            }
            else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
