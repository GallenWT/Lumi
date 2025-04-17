//
//  GestureHandling.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 19/06/24.
//

import SpriteKit

// Extension kasarannya perpanjangan code dari GameScene
// Buat misahin aja si sebenarnya biar gak numpuk

extension GameScene {
    
    // MARK: - Gesture Handling
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let view = self.view else { return }
        let translation = gesture.translation(in: view)
        gesture.setTranslation(.zero, in: view)
        
        var newPosition = BgNode.position
        newPosition.x += translation.x
        newPosition.y -= translation.y
        
        // Set batas geser mengikuti zoom level
        let scaledWidth = size.width * BgNode.xScale
        let scaledHeight = size.height * BgNode.yScale
        
        let xPos = max(min(newPosition.x, scaledWidth / 0.8), -scaledWidth / 0.8)
        let yPos = max(min(newPosition.y, scaledHeight / 2.95), -scaledHeight / 2.95)
        
        BgNode.position = CGPoint(x: xPos, y: yPos)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = self.view else { return }
        
        if gesture.state == .began || gesture.state == .changed {
            let scale = gesture.scale
            let locationInView = gesture.location(in: view)
            let locationInScene = convertPoint(fromView: locationInView)
            
            let oldScale = BgNode.xScale
            let newScale = oldScale * scale
            let minScale: CGFloat = 0.3
            let maxScale: CGFloat = 2.0
            let clampedScale = min(max(newScale, minScale), maxScale)
            
            let deltaScale = clampedScale / oldScale
            
            let newPosition = CGPoint(
                x: (BgNode.position.x - locationInScene.x) * deltaScale + locationInScene.x,
                y: (BgNode.position.y - locationInScene.y) * deltaScale + locationInScene.y
            )
            
            BgNode.setScale(clampedScale)
            BgNode.position = newPosition
            gesture.scale = 1.0
            
            // Set batas geser mengikuti zoom level
            let scaledWidth = size.width * clampedScale
            let scaledHeight = size.height * clampedScale
            
            let xPos = max(min(BgNode.position.x, scaledWidth / 0.8), -scaledWidth / 0.8)
            let yPos = max(min(BgNode.position.y, scaledHeight / 2.95), -scaledHeight / 2.95)
            
            BgNode.position = CGPoint(x: xPos, y: yPos)
        }
    }
}
