//
//  ChallengeScene.swift
//  Eyeeye
//
//  Created by Syafrie Bachtiar on 12/06/24.
//

import SpriteKit

//Timer Belum Jalan
class ChallengeScene: SKScene {
    private var timerNode: SKSpriteNode!
    private var timerLabel: SKLabelNode!
    
    private var timer: Timer?
    private var remainingTime: Int = 20
    
    override func didMove(to view: SKView) {
        self.SetUp()
    }
    
    func SetUp(){
        if let node = self.childNode(withName: "Play") as? SKSpriteNode {
            timerNode = node
        }
        
        timerLabel = SKLabelNode(text: "Time: 20")
        timerLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        timerLabel.fontSize = 24
        timerLabel.fontColor = .white
        addChild(timerLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if touchedNodes.contains(timerNode) {
            startTimer()
            print("Pressed")
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        remainingTime = 20
        timerLabel.text = "Time: \(remainingTime)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.remainingTime -= 1
            self.timerLabel.text = "Time: \(self.remainingTime)"
            
            if self.remainingTime <= 0 {
                timer.invalidate()
            }
        }
    }
    
    override func willMove(from view: SKView) {
        timer?.invalidate()
    }
}
