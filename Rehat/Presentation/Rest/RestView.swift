//
//  RestView.swift
//  Rehat
//
//  Created by Darren Thiores on 20/06/24.
//

import SwiftUI
import AVFoundation

struct RestView: View {
    @StateObject private var restVM = RestViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var audioPlayer: AVAudioPlayer? = nil
    
    private var currentMinute: String {
        let minute = Int(restVM.currentSecond) / 60
        
        if minute <= 9 {
            if minute <= 0 {
                return "00"
            } else {
                return "0\(minute)"
            }
        } else {
            return "\(minute)"
        }
    }
    private var currentSecond: String {
        let second = Int(restVM.currentSecond) % 60
        
        if second <= 9 {
            if second <= 0 {
                return "00"
            } else {
                return "0\(second)"
            }
        } else {
            return "\(second)"
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                
                switch restVM.currentSection {
                case .StartSection:
                    VStack(spacing: 12) {
                        Text("Time to rest your eyes!")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.cream)
                        
                        RestCircleButton(
                            onClick: {
                                restVM.onEvent(event: .StartRest)
                            }
                        )
                    }
                case .LoadSection:
                    Text("Look across the room or close your eyes until the timer rings")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.cream)
                        .multilineTextAlignment(.center)
                        .padding(64)
                case .OnRestSection:
                    VStack(spacing: 8) {
                        Text("Rest for")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.cream)
                        
                        Text("\(currentMinute):\(currentSecond)")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundStyle(.cream)
                    }
                }
            }
            .background(
                Image("RestBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            HapticManager.shared.prepare()
            restVM.onEvent(event: .UpdateTimer)
        }
        .onDisappear {
            audioPlayer?.stop()
            audioPlayer = nil
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                HapticManager.shared.prepare()
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
        .sensoryFeedback(
            .impact(flexibility: .soft, intensity: 1),
            trigger: restVM.currentSecond
        )
    }
    
    private func playAudio() {
        audioPlayer?.stop()
        
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
    }
}

#Preview {
    RestView()
}
