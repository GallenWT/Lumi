//
//  HomeView.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 23/06/24.
//

import SwiftUI
import AVFoundation
import WatchKit

struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel()
    @State private var isScaleAnimating = false
    @State private var audioPlayer: AVAudioPlayer? = nil

    @Environment(\.scenePhase) private var scenePhase
    
    private var currentMinute: String {
        String(format: "%02d", homeVM.currentSecond / 60)
    }
    
    private var currentSecond: String {
        String(format: "%02d", homeVM.currentSecond % 60)
    }
    
    private let titleText = "Reminder \nnot activated"
    private let textSubtitle = "Rest in"
    private let textColor = Color("TextGreen")

    
    var body: some View {
        ZStack {
            
            Image("Open-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                
                if homeVM.status == .Set {
                    Text(textSubtitle)
                        .font(.system(size: 15, design: .rounded))
                        .fontWeight(.regular)
                        .foregroundColor(textColor)
                    
                    Text("\(currentMinute):\(currentSecond)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                    
                } else {
                    Text (titleText)
                        .font(.system(size: 20, design: .rounded))
                        .foregroundStyle(textColor)
                        .fontWeight(.bold)
                        .padding()
                        .lineSpacing(2)
                }
                
                Button(action: {
                    if homeVM.status == .Set {
                        homeVM.onEvent(event: .StopReminder)
                        isScaleAnimating.toggle()
                        playAudio()
                    } else {
                        homeVM.onEvent(event: .StartReminder)
                        isScaleAnimating.toggle()
                        playAudio()
                    }
                    
                    
                }) {
                    Text(homeVM.status.buttonText())
                }
                .buttonStyle(CustomReminderButton(buttonType: homeVM.status))
                .padding(.horizontal, 22)
                .scaleEffect(isScaleAnimating ? 1.1 : 1.0)
                .onChange(of: isScaleAnimating) {
                    if isScaleAnimating {
                        withAnimation(
                            .easeInOut(duration: 0.5)
                        ) {
                            isScaleAnimating.toggle()
                        }
                    }
                }
                
                
            }.padding(.top, 65)
            
        }
        .onAppear {
            homeVM.onEvent(
                event: .ResetTimer
            )
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                homeVM.onEvent(
                    event: .ResetTimer

                )
            }
        }
    }
    
    private func playAudio() {
        audioPlayer?.stop()
        
        if let fileName = Bundle.main.path(
            forResource: "FrogsSound",
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
        
        
        audioPlayer?.play()
        
        WKInterfaceDevice.current().play(.success)
    }
}

#Preview {
    HomeView()
}
