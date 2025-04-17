//
//  Currency.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 19/06/24.
//

import SpriteKit

extension GameScene{
    
    //Gak Dipakek keperluan debug
    func incrementNominal() {
        var currentValue = Int(nominalLabel.text ?? "0") ?? 0
        currentValue += 1
        
        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
    func saveNominalValue(_ value: Int) {
//        UserDefaults.standard.set(value, forKey: nominalKey)
//        UserDefaults(suiteName: AppGroupManager.suiteName)?
//            .set(value, forKey: "currency")
        
        guard let userDefaults = UserDefaults(suiteName: AppGroupManager.suiteName) else {
            return
        }
        
        userDefaults.set(value, forKey: "currency")
        
    }
    
    //Ambil Load Nominal Value dari darren
    func loadNominalValue() {
//        let savedValue = UserDefaults.standard.integer(forKey: nominalKey)
        let savedValue = UserDefaults(suiteName: AppGroupManager.suiteName)?
            .integer(forKey: "currency")
        nominalLabel.text = "\(savedValue)"
    }
    
    // MARK: - StorePopupDelegate
    // Save ke SwiftData Belum
    func createSpriteNode(at position: CGPoint) {
        guard let BgNode = BgNode else { return }
        
        let newNode = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        
        // Set Random Posisi SpriteNode diantara posisi background
        // Biar SpriteNode gak keluar batas background
        
        let minX = -BgNode.size.width / 2
        let maxX = BgNode.size.width / 2
        let minY = -BgNode.size.height / 2
        let maxY = BgNode.size.height / 2
        
        let randomX = CGFloat.random(in: minX...maxX)
        let randomY = CGFloat.random(in: minY...maxY)
        
        newNode.position = CGPoint(x: randomX, y: randomY)
        BgNode.addChild(newNode)
        
        //Zoom in ke node baru???
        BgNode.position = newNode.position
        
        // Add pop-out animation
        newNode.setScale(0)
        let popOutAction = SKAction.scale(to: 1.0, duration: 0.3)
        newNode.run(popOutAction)
        
        // Update nominal value
        var currentValue = Int(nominalLabel.text ?? "0") ?? 0
        currentValue -= 5
        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
        //4
    }
    
    func getCurrentNominal() -> Int {
        
        guard let userDefaults = UserDefaults(suiteName: AppGroupManager.suiteName) else {
                // Jika tidak bisa mendapatkan UserDefaults, kembalikan nilai default misalnya 0
                return 0
            }
        
        let savedValue = userDefaults.integer(forKey: "currency")
//        return Int(nominalLabel.text ?? "0") ?? 0
        return savedValue
    }
    
}
