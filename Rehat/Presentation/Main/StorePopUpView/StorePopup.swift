//
//  StorePopup.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 17/06/24.
//

//Bug gabisa ditutup

//PopUp Store dari PondView
import SpriteKit

protocol StorePopupDelegate: AnyObject {
    func createSpriteNode(at position: CGPoint)
    func getCurrentNominal() -> Int
    //3
}

class StorePopup: SKNode {
    private var storePopup: SKSpriteNode!
    private var closeButton: SKSpriteNode!
    private var buyButton: SKSpriteNode!
    weak var delegate: StorePopupDelegate?
    
    override init() {
        super.init()
        self.setUpStorePopup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpStorePopup()
    }
    
    private func setUpStorePopup() {
        storePopup = SKSpriteNode(color: .black, size: CGSize(width: 300, height: 400))
        storePopup.alpha = 0.8
        storePopup.zPosition = 1000
        storePopup.position = CGPoint(x: 0, y: 0)
        
        closeButton = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        closeButton.position = CGPoint(x: 0, y: storePopup.size.height / 2 - 25)
        closeButton.name = "closeButton"
        
        buyButton = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 50))
        buyButton.position = CGPoint(x: 0, y: 0)
        buyButton.name = "buyButton"
        
        storePopup.addChild(closeButton)
        storePopup.addChild(buyButton)
        storePopup.isHidden = true
        addChild(storePopup)
    }
    
    func show() {
        storePopup.isHidden = false
        storePopup.run(SKAction.scale(to: 1.0, duration: 0.2))
    }
    
    func hide() {
        storePopup.run(SKAction.sequence([
            SKAction.scale(to: 0.0, duration: 0.2),
            SKAction.run { [weak self] in
                self?.storePopup.isHidden = true
            }
        ]))
    }
    
    func handleTouch(_ location: CGPoint) -> Bool {
        let touchedNodes = nodes(at: location)
        if touchedNodes.contains(closeButton) {
            hide()
            return true
        } else if touchedNodes.contains(buyButton) {
            attemptToBuy()
            //1
            return true
        }
        return false
    }
    
    private func attemptToBuy() {
        guard let delegate = delegate else { return }
        let currentNominal = delegate.getCurrentNominal()
        
        if currentNominal >= 5 {
            let targetPosition = CGPoint(x: 100, y: 100)
            //Kasi kabar untuk createnode dengan posisi target position
            delegate.createSpriteNode(at: targetPosition)
            //2
        } else {
            print("Gak ada duit")
        }
    }
}
