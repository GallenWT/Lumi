//
//  ConfirmationModal.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 25/06/24.
//

import SpriteKit

class ConfirmationModal: SKNode {
    var background: SKSpriteNode
    var yesButton: SKSpriteNode
    var noButton: SKSpriteNode
    var textconfirm: SKSpriteNode
    var costtext: SKSpriteNode
    var lumicoin: SKSpriteNode
    var priceLabel: SKLabelNode
    
    var costLabel: SKLabelNode
    var confirmLabel: SKLabelNode
    
    var dimBackground: SKSpriteNode
    
    var onConfirm: (() -> Void)?
    var onCancel: (() -> Void)?
    
    init(size: CGSize) {
        background = SKSpriteNode(imageNamed: "Confirmation")
        yesButton = SKSpriteNode(imageNamed: "YesNew")
        noButton = SKSpriteNode(imageNamed: "NoNew")
        textconfirm = SKSpriteNode(imageNamed: "UnlockText")
        costtext = SKSpriteNode(imageNamed: "costtext")
        lumicoin = SKSpriteNode(imageNamed: "coin")
        
        priceLabel = SKLabelNode(fontNamed: "SF-Pro-Rounded-Bold")
        costLabel = SKLabelNode(fontNamed: "SF Pro")
        confirmLabel = SKLabelNode(fontNamed: "SF Pro")
        
        dimBackground = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: CGSize(width: size.width * 4, height: size.height * 6))
        
        super.init()
        
        dimBackground.position = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        yesButton.position = CGPoint(x: 60, y: -size.height / 3.5)
        noButton.position = CGPoint(x: -60, y: -size.height / 3.5)
        
        costtext.position = CGPoint(x: 0, y: size.height / 2.5)
        costLabel.position = CGPoint(x: 0, y: size.height / 3)
        
        textconfirm.position = CGPoint(x: 0, y: 0)
        confirmLabel.position = CGPoint(x: 0, y: 0)
        
        lumicoin.position = CGPoint(x: 30, y: size.height / 5.0)
        priceLabel.position = CGPoint(x: -20, y: size.height / 6.5)
        
        dimBackground.zPosition = 7
        background.zPosition = 8
        yesButton.zPosition = 9
        noButton.zPosition = 9
        textconfirm.zPosition = 9
        costtext.zPosition = 9
        lumicoin.zPosition = 9
        
        priceLabel.zPosition = 9
        costLabel.zPosition = 9
        confirmLabel.zPosition = 9
        
        lumicoin.xScale = 0.2
        lumicoin.yScale = 0.2
        
        yesButton.xScale = 0.25
        yesButton.yScale = 0.25
        
        noButton.xScale = 0.25
        noButton.yScale = 0.25
        
        if let customColor = UIColor(named: "TextGreen"){
            priceLabel.fontColor = customColor
        }
        
        costLabel.fontColor = .black
        confirmLabel.fontColor = .black
        
        priceLabel.fontSize = 25
        costLabel.fontSize = 20
        confirmLabel.fontSize = 20
        
        addChild(background)
        addChild(yesButton)
        addChild(noButton)
//        addChild(textconfirm)
//        addChild(costtext)
        addChild(lumicoin)
        
        addChild(priceLabel)
        addChild(costLabel)
        addChild(confirmLabel)
        
        addChild(dimBackground)
        
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(price: String) {
        priceLabel.text = price
        costLabel.text = "This will cost you"
        confirmLabel.text = "Do you want to unlock?"
//        position = CGPoint(x: scene.size.width, y: scene.size.height)
//        overlay.run(SKAction.fadeAlpha(to: 0.5, duration: 0.2))
//        background.alpha = 0.7
        isHidden = false
    }
    
    func hide() {
//        /*overlay.run(SKAction.fadeAlpha(to: 0.0, duration: 0.2))*/ {
//            self.isHidden = true
//        background.alpha = 0
        isHidden = true
//        }
    }
    
    func handleTouch(_ location: CGPoint) -> Bool {
        let locationInModal = self.convert(location, from: self.scene!)
        
        if yesButton.contains(locationInModal) {
            onConfirm?()
            hide()
            return true
        } 
        
        else if noButton.contains(locationInModal) {
            onCancel?()
            hide()
            return true
        }
        
        return false
    }
}

