//
//  MainView.swift
//  Eyeeye
//
//  Created by Syafrie Bachtiar on 10/06/24.
//

//GameScene diwadahi di SwiftUI
import SwiftUI
import AVFoundation

struct MainView: View {
    @StateObject private var mainVM = MainViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var audioPlayer: AVAudioPlayer? = nil
    
    var body: some View {
        VStack {
            SpriteKitView()
                .ignoresSafeArea()
        }
        .overlay {
            ReminderOverlay(
                countDown: mainVM.currentSecond,
                onEvent: { event in
                    mainVM.onEvent(event: event)
                    
                    if event == .StartReminder || event == .StopReminder {
                         playAudio()
                    }
                }
            )
        }
        .overlay {
            if mainVM.showTutorial {
                if mainVM.showSkipAlert {
                    AlertOverlay(
                        text: MainText.skipTutorialAlertText,
                        onDismiss: {
                            mainVM.onEvent(event: .ToggleSkipAlert)
                        },
                        onActionClick: {
                            if mainVM.tutorialSection == .Rest || mainVM.tutorialSection == .Stop {
                                mainVM.onEvent(event: .StopReminder)
                            }
                            
                            mainVM.onEvent(event: .SkipTutorial)
                        }
                    )
                } else {
                    switch mainVM.tutorialSection {
                    case .Welcome:
                        TutorialOverlay(
                            text: MainText.welcomeTutorialText,
                            image: "WelcomeFrog",
                            tapToContinue: true,
                            onSkipClick: {
                                mainVM.onEvent(event: .ToggleSkipAlert)
                            }
                        )
                        .onTapGesture {
                            mainVM.onEvent(event: .ContinueTutorial)
                        }
                    case .Start:
                        ActionTutorialOverlay(
                            text: MainText.startTutorialText,
                            image: "StartFrog",
                            onSkipClick: {
                                mainVM.onEvent(event: .ToggleSkipAlert)
                            },
                            reminderStatus: .NotSet,
                            onButtonClick: {
                                playAudio()
                                mainVM.onEvent(event: .StartReminder)
                                mainVM.onEvent(event: .ContinueTutorial)
                            }
                        )
                    case .Rest:
                        TutorialOverlay(
                            text: MainText.restTutorialText,
                            image: "RestFrog",
                            tapToContinue: true,
                            onSkipClick: {
                                mainVM.onEvent(event: .ToggleSkipAlert)
                            }
                        )
                        .onTapGesture {
                            mainVM.onEvent(event: .ContinueTutorial)
                        }
                    case .Stop:
                        ActionTutorialOverlay(
                            text: MainText.stopTutorialText,
                            image: "StopFrog",
                            onSkipClick: {
                                mainVM.onEvent(event: .ToggleSkipAlert)
                            },
                            reminderStatus: .Set,
                            onButtonClick: {
                                playAudio()
                                
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 0.5
                                ) {
                                    mainVM.onEvent(event: .StopReminder)
                                    mainVM.onEvent(event: .FinishTutorial)
                                }
                            }
                        )
                    }
                }
            }
        }
        .overlay {
            if mainVM.showStartAlert {
                AlertOverlay(
                    text: MainText.startTutorialText
                )
                .onTapGesture {
                    mainVM.onEvent(event: .ToggleStartAlert)
                    mainVM.onEvent(event: .FinishTutorial)
                }
            }
        }
        .onAppear {
            HapticManager.shared.prepare()
            setupAudio()
            
            mainVM.onEvent(
                event: .ResetTutorial
            )
            
            mainVM.onEvent(
                event: .ResetTimer
            )
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                HapticManager.shared.prepare()
                
                mainVM.onEvent(
                    event: .ResetTimer
                )
            }
        }
        .onDisappear {
            audioPlayer?.stop()
            audioPlayer = nil
        }
    }
    
    private func setupAudio() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let fileName = Bundle.main.path(
                forResource: "Kwebek",
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
            
            audioPlayer?.prepareToPlay()
        }
    }
    
    private func playAudio() {
        DispatchQueue.global(qos: .userInitiated).async {
            audioPlayer?.play()
        }
    }
}

#Preview {
    MainView()
}
