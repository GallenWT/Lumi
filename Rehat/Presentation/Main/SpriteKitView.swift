//
//  SpriteKitView.swift
//  Eyeeye
//
//  Created by Syafrie Bachtiar on 10/06/24.
//

//Untuk Ceplokin GameScene ke SwiftUI
import SwiftUI
import SpriteKit

struct SpriteKitView: UIViewRepresentable {
    //LoadGameScene disini
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .resizeFill
            skView.presentScene(scene)
        }
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        
    }
}

