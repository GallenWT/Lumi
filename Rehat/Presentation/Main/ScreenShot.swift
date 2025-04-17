//
//  ScreenShot.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 19/06/24.
//

import SpriteKit

extension GameScene {
    
    func takeScreenshotAndSave() {
        guard let view = self.view else { return }
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            showMessage("Image saved")
        } else {
            showMessage("Save failed")
        }
    }
    
    func showMessage(_ message: String) {
        messageLabel.text = message
        messageLabel.run(SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.25),
            SKAction.wait(forDuration: 2.0),
            SKAction.fadeOut(withDuration: 0.25),
            SKAction.run { [weak self] in
                self?.messageLabel.text = ""
            }
        ]))
    }
    
}
