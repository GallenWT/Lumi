//
//  RestView.swift
//  Lumi Watch App
//
//  Created by Darren Thiores on 24/06/24.
//

import SwiftUI
import AVFoundation
import WatchKit

struct RestView: View {
    @StateObject private var restVM = RestViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var audioPlayer: AVAudioPlayer? = nil
    @State private var hapticTimer: Timer? = nil

    
    private var currentMinute: String {
        String(format: "%02d", restVM.currentSecond / 60)
    }
    
    private var currentSecond: String {
        String(format: "%02d", restVM.currentSecond % 60)
    }
    
    private let textColor = Color(hex: "FFE9C9")
    private let myBackgroundColor = Color(hex: "3F9287")
    var textRestFor = "Rest for"
    
    var body: some View {
        ZStack {
            switch restVM.currentSection {
            case .StartSection:
                RestButton(
                    onClick: {
                        restVM.onEvent(event: .StartRest)
                    }
                )
            case .LoadSection:
                LookAround()
            case .OnRestSection:
                ZStack {
                    Image("rest-background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    VStack{
                        Text(textRestFor)
                            .font(.system(size: 15, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(textColor)
                        
                        Text("\(currentMinute):\(currentSecond)")
                            .font(.system(size: 32, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(textColor)
                        
                        
                    }
                }
            }
        }
        .onAppear {
            restVM.onEvent(event: .UpdateTimer)
        }
        .onDisappear {
            hapticTimer?.invalidate()
            hapticTimer = nil

            audioPlayer?.stop()
            audioPlayer = nil
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                switch restVM.currentSection {
                case .StartSection:
                    restVM.onEvent(event: .UpdateTimer)
                case .LoadSection:
                    restVM.onEvent(event: .Reload)
                case .OnRestSection:
                    restVM.onEvent(event: .UpdateTimer)
                    playAudio()
                }
            }
        }
        .onChange(of: restVM.currentSection) {
            if restVM.currentSection == .OnRestSection {
                playAudio()
            }
        }
    }
    
    private func playAudio() {
        audioPlayer?.stop()
        hapticTimer?.invalidate()
        
        if let fileName = Bundle.main.path(
            forResource: "Tick",
            ofType: "mp3"
        ) {
            audioPlayer = try? AVAudioPlayer(
                contentsOf: URL(fileURLWithPath: fileName)
            )
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
        
        hapticTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    WKInterfaceDevice.current().play(.success)
                }
    }
}

#Preview {
    RestView()
}
