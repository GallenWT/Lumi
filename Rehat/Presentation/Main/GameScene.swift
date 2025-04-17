//
//  GameScene.swift
//  Eyeeye
//
//  Created by Syafrie Bachtiar on 10/06/24.
//

import SpriteKit
import GameplayKit
import CoreData

//Tambahan: Saat beli map muncul popup modality confirmation.
//          Latar belakangnya ke fade
//          Popupnya muncul dengan animation bounce
//Suara Pond berubah setiap geser map(optional)

class GameScene: SKScene, StorePopupDelegate {
    
    var confirmationModal: ConfirmationModal!
    var cameraNode = SKCameraNode()
    
    // SpriteNode
    private var SSNode: SKSpriteNode!
    private var StoreNode: SKSpriteNode!
    //Konsep OOP: Di public biar bisa diakses di swift berbeda
    public var BgNode: SKSpriteNode!
    
    //MapUnlocked Node
    private var Map2node : SKSpriteNode!
    private var Map3node : SKSpriteNode!
    private var Map4node : SKSpriteNode!
    private var Map5node : SKSpriteNode!
    private var Map6node : SKSpriteNode!
    private var Map7node : SKSpriteNode!
    
    private var plusNode: SKSpriteNode!
    
    private var Bnode2: SKSpriteNode!
    private var Bnode3: SKSpriteNode!
    private var Bnode4: SKSpriteNode!
    private var Bnode5: SKSpriteNode!
    private var Bnode6: SKSpriteNode!
    private var Bnode7: SKSpriteNode!
    
    //tambahan label harga
    private var nodeHarga2: SKLabelNode!
    private var nodeHarga3: SKLabelNode!
    private var nodeHarga4: SKLabelNode!
    private var nodeHarga5: SKLabelNode!
    private var nodeHarga6: SKLabelNode!
    private var nodeHarga7: SKLabelNode!
    
    // Instance StorePopup
    private var storePopup: StorePopup!
    let nominalKey = "NominalValue"
    
    // LabelNode : Text
    //Konsep OOP: Di public biar bisa diakses di swift berbeda
    public var nominalLabel: SKLabelNode!
    //Konsep OOP : Di public biar bisa diakses di swift berbeda
    public var messageLabel: SKLabelNode!
    
    var panGesture: UIPanGestureRecognizer!
    var pinchGesture: UIPinchGestureRecognizer!
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.setUpScene()
        
        loadNodesIntoScene()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        loadNominalValue()
        
    }
    
    func setUpScene() {
        
        //Inisiasi Node yang ada di GameScene.sks
        if let node = self.childNode(withName: "ScreenShot") as? SKSpriteNode {
            SSNode = node
        }
        
        if let node2 = self.childNode(withName: "Store") as? SKSpriteNode {
            StoreNode = node2
        }
        
        if let background = self.childNode(withName: "BackgroundCity") as? SKSpriteNode {
            BgNode = background
        }
        
        if let label = self.childNode(withName: "Nominal") as? SKLabelNode {
            nominalLabel = label
        }
        
        if let plus = self.childNode(withName: "Plus") as? SKSpriteNode {
            plusNode = plus
        }
        
        //akses ke node dalam node
        if let parentNode = self.childNode(withName: "BackgroundCity") as? SKSpriteNode {
            if let childNode = parentNode.childNode(withName: "Map2") as? SKSpriteNode {
                Map2node = childNode
            }
            
            if let childNode1 = parentNode.childNode(withName: "Map3") as? SKSpriteNode {
                Map3node = childNode1
            }
            
            if let childNode2 = parentNode.childNode(withName: "Map4") as? SKSpriteNode {
                Map4node = childNode2
            }
            
            if let childNode3 = parentNode.childNode(withName: "Map5") as? SKSpriteNode {
                Map5node = childNode3
            }
            
            if let childNode4 = parentNode.childNode(withName: "Map6") as? SKSpriteNode {
                Map6node = childNode4
            }
            
            if let childNode5 = parentNode.childNode(withName: "Map7") as? SKSpriteNode {
                Map7node = childNode5
            }
            
            //Font Label Harga
            if let BMnode2 = parentNode.childNode(withName: "BuyMap2") as? SKSpriteNode {
                Bnode2 = BMnode2
                if let harga2 = BMnode2.childNode(withName: "LabelHarga2") as? SKLabelNode{
                    nodeHarga2 = harga2
                    nodeHarga2.text = "300"
                    nodeHarga2.fontName = "SF Pro"
                }
            }
            
            if let BMnode3 = parentNode.childNode(withName: "BuyMap3") as? SKSpriteNode {
                Bnode3 = BMnode3
                if let harga3 = BMnode3.childNode(withName: "LabelHarga3") as? SKLabelNode{
                    nodeHarga3 = harga3
                    nodeHarga3.text = "450"
                    nodeHarga3.fontName = "SF Pro"
                }
            }
            
            if let BMnode4 = parentNode.childNode(withName: "BuyMap4") as? SKSpriteNode {
                Bnode4 = BMnode4
                if let harga4 = BMnode4.childNode(withName: "LabelHarga4") as? SKLabelNode{
                    nodeHarga4 = harga4
                    nodeHarga4.text = "750"
                    nodeHarga4.fontName = "SF Pro"
                }
            }
            
            if let BMnode5 = parentNode.childNode(withName: "BuyMap5") as? SKSpriteNode {
                Bnode5 = BMnode5
                if let harga5 = BMnode5.childNode(withName: "LabelHarga5") as? SKLabelNode{
                    nodeHarga5 = harga5
                    nodeHarga5.text = "600"
                    nodeHarga5.fontName = "SF Pro"
                }
            }
            
            if let BMnode6 = parentNode.childNode(withName: "BuyMap6") as? SKSpriteNode {
                Bnode6 = BMnode6
                if let harga6 = BMnode6.childNode(withName: "LabelHarga6") as? SKLabelNode{
                    nodeHarga6 = harga6
                    nodeHarga6.text = "900"
                    nodeHarga6.fontName = "SF Pro"
                }
            }
            
            if let BMnode7 = parentNode.childNode(withName: "BuyMap7") as? SKSpriteNode {
                Bnode7 = BMnode7
                if let harga7 = BMnode7.childNode(withName: "LabelHarga7") as? SKLabelNode{
                    nodeHarga7 = harga7
                    nodeHarga7.text = "150"
                    nodeHarga7.fontName = "SF Pro"
                }
            }
            
        }
        
        //Create node baru
        messageLabel = SKLabelNode(text: "")
        messageLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        messageLabel.fontSize = 24
        messageLabel.fontColor = .white
        addChild(messageLabel)
        
        // Initialize and add StorePopup
        storePopup = StorePopup()
        storePopup.position = CGPoint(x: size.width / 2, y: size.height / 2)
        storePopup.delegate = self
        addChild(storePopup)
        
        addChild(cameraNode)
        camera = cameraNode
        
        confirmationModal = ConfirmationModal(size: CGSize(width: 300, height: 200))
        cameraNode.addChild(confirmationModal)
        
//        BgNode.addChild(confirmationModal)
        
        updateConfirmationModalPosition()
    }
    
    func disableGestureRecognizers() {
        panGesture.isEnabled = false
        pinchGesture.isEnabled = false
    }
    
    func enableGestureRecognizers() {
        panGesture.isEnabled = true
        pinchGesture.isEnabled = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        updateConfirmationModalPosition()
    }
    
    func updateConfirmationModalPosition() {
        
        confirmationModal.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y)
        
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if confirmationModal.isHidden == false {
            if confirmationModal.handleTouch(location) {
                enableGestureRecognizers()
                return
            }
        }
        
        func showConfirmationModal(for action: @escaping () -> Void, price: String) {
            confirmationModal.onConfirm = action
            confirmationModal.show(price: price)
            disableGestureRecognizers()
        }
        
        if let node = touchedNodes.first(where: { $0 == Bnode2 || $0 == Bnode3 || $0 == Bnode4 || $0 == Bnode5 || $0 == Bnode6 || $0 == Bnode7 }) {
            
            if node == Bnode2 {
                showConfirmationModal(for: { self.BuyMap() }, price: "300")
            } 
            
            else if node == Bnode3 {
                showConfirmationModal(for: { self.BuyMap3() }, price: "450")
            }
            
            else if node == Bnode4 {
                showConfirmationModal(for: { self.BuyMap4() }, price: "750")
            }
            
            else if node == Bnode5 {
                showConfirmationModal(for: { self.BuyMap5() }, price: "600")
            }
            
            else if node == Bnode6 {
                showConfirmationModal(for: { self.BuyMap6() }, price: "900")
            }
            
            else if node == Bnode7 {
                showConfirmationModal(for: { self.BuyMap7() }, price: "150")
            }
            
        } 
        
        else {
            if storePopup.handleTouch(location) {
                return
            }
        }
    }
    
    //Mekanisme beli peta
    private func BuyMap() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 300 {
            NewMap()
        } else {
            print("Gak ada duit")
        }
    }
    
    private func BuyMap3() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 450 {
            NewMap3()
        } else {
            print("Gak ada duit")
        }
    }
    
    private func BuyMap4() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 750 {
            NewMap4()
        } else {
            print("Gak ada duit")
        }
    }
    
    private func BuyMap5() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 600 {
            NewMap5()
        } else {
            print("Gak ada duit")
        }
    }
    
    private func BuyMap6() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 900 {
            NewMap6()
        } else {
            print("Gak ada duit")
        }
    }
    
    private func BuyMap7() {
        let currentNominal = getCurrentNominal()
        //set harga disini
        if currentNominal >= 150 {
            NewMap7()
        } else {
            print("Gak ada duit")
        }
    }
    
    //Save Map dengan CoreData
    func loadNodesIntoScene() {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MapNode")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let imageName = data.value(forKey: "imageName") as! String
                let positionX = data.value(forKey: "positionX") as! Double
                let positionY = data.value(forKey: "positionY") as! Double
                let anchorPointX = data.value(forKey: "anchorPointX") as! Double
                let anchorPointY = data.value(forKey: "anchorPointY") as! Double
                let zPosition = data.value(forKey: "zPosition") as! Double
                
                let node = SKSpriteNode(imageNamed: imageName)
                node.position = CGPoint(x: positionX, y: positionY)
                node.anchorPoint = CGPoint(x: anchorPointX, y: anchorPointY)
//                node.zPosition = CGFloat(zPosition)
                node.zPosition = 4
                
                //kasi if jika data yang disimpan merupakan data ini maka hapus interaksi node ini
                if imageName == "KodokPink"{
                    Bnode2.removeFromParent()
                }
                
                else if imageName == "KodokMerah"{
                    Bnode3.removeFromParent()
                }
                
                else if imageName == "KodokOnsen"{
                    Bnode4.removeFromParent()
                }
                
                else if imageName == "KodokNaruto"{
                    Bnode5.removeFromParent()
                }
                
                else if imageName == "KodokMancing"{
                    Bnode6.removeFromParent()
                }
                
                else if imageName == "KodokKupu"{
                    Bnode7.removeFromParent()
                }
                
                // Pastikan BgNode sudah diinisialisasi sebelum menambahkan node
                if let bgNode = BgNode {
                    bgNode.addChild(node)
                } else {
                    print("BgNode is not initialized")
                }
            }
            print("Nodes loaded successfully") // Debugging
        } catch {
            print("Failed loading nodes: \(error)")
        }
    }
    
    func NewMap(){
        guard let Map2node = Map2node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode2 = Bnode2 else { return}
        guard let nodeHarga2 = nodeHarga2 else { return }
        
        //Instantiate Node baru dari asset
        let Map2New = SKSpriteNode(imageNamed: "KodokPink")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map2New.anchorPoint = CGPoint(x:0.5, y: 0)
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map2New.position = Map2node.position
        Map2New.zPosition = 4
        
        //Masukkan ke childnya background
        BgNode.addChild(Map2New)
        
        //Hapus map sebelumnya
        Map2node.removeFromParent()
        Bnode2.removeFromParent()
        nodeHarga2.removeFromParent()
        
        saveMapNode(imageName: "KodokPink", position: Map2New.position, anchorPoint: Map2New.anchorPoint, zPosition: Map2New.zPosition)
        
        // Update nominal value
        var currentValue = getCurrentNominal()
        currentValue -= 300
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
        
    }
    
    func NewMap3(){
        guard let Map3node = Map3node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode3 = Bnode3 else { return }
        guard let nodeHarga3 = nodeHarga3 else {return}
        
        //Instantiate Node baru dari asset
        let Map3New = SKSpriteNode(imageNamed: "KodokMerah")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map3New.anchorPoint = CGPoint(x: 0.5, y: 0.45)
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map3New.position = Map3node.position
        Map3New.zPosition = 6
        
        //Masukkan ke childnya background
        BgNode.addChild(Map3New)
        
        //Hapus map sebelumnya
        Map3node.removeFromParent()
        Bnode3.removeFromParent()
        nodeHarga3.removeFromParent()
        
        saveMapNode(imageName: "KodokMerah", position: Map3New.position, anchorPoint: Map3New.anchorPoint, zPosition: Map3New.zPosition)
        
        // Update nominal value
        var currentValue = getCurrentNominal()
        currentValue -= 450
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
    func NewMap4(){
        guard let Map4node = Map4node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode4 = Bnode4 else { return}
        guard let nodeHarga4 = nodeHarga4 else { return }
        
        //Instantiate Node baru dari asset
        let Map4New = SKSpriteNode(imageNamed: "KodokOnsen")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map4New.anchorPoint = CGPoint(x:0.5, y: 0.53)
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map4New.position = Map4node.position
        Map4New.zPosition = 4
        
        //Masukkan ke childnya background
        BgNode.addChild(Map4New)
        
        //Hapus map sebelumnya
        Map4node.removeFromParent()
        Bnode4.removeFromParent()
        nodeHarga4.removeFromParent()
        
        saveMapNode(imageName: "KodokOnsen", position: Map4New.position, anchorPoint: Map4New.anchorPoint, zPosition: Map4New.zPosition)
        
        // Update nominal value
        var currentValue = getCurrentNominal()
        currentValue -= 750
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
    func NewMap5(){
        guard let Map5node = Map5node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode5 = Bnode5 else { return}
        guard let nodeHarga5 = nodeHarga5 else { return }
        
        //Instantiate Node baru dari asset
        let Map5New = SKSpriteNode(imageNamed: "KodokNaruto")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map5New.anchorPoint = CGPoint(x:0.5, y: 0.5)
        Map5New.zPosition = 4
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map5New.position = Map5node.position
        
        //Masukkan ke childnya background
        BgNode.addChild(Map5New)
        
        //Hapus map sebelumnya
        Map5node.removeFromParent()
        Bnode5.removeFromParent()
        nodeHarga5.removeFromParent()
        
        saveMapNode(imageName: "KodokNaruto", position: Map5New.position, anchorPoint: Map5New.anchorPoint, zPosition: Map5New.zPosition)
        
        // Update nominal value
        var currentValue = getCurrentNominal()
        currentValue -= 600
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
    func NewMap6(){
        guard let Map6node = Map6node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode6 = Bnode2 else { return}
        guard let nodeHarga6 = nodeHarga2 else { return }
        
        //Instantiate Node baru dari asset
        let Map6New = SKSpriteNode(imageNamed: "KodokMancing")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map6New.anchorPoint = CGPoint(x:0.5, y: 0.4)
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map6New.position = Map6node.position
        Map6New.zPosition = 4
        
        //Masukkan ke childnya background
        BgNode.addChild(Map6New)
        
        //Hapus map sebelumnya
        Map6node.removeFromParent()
        Bnode6.removeFromParent()
        nodeHarga6.removeFromParent()
        
        saveMapNode(imageName: "KodokMancing", position: Map6New.position, anchorPoint: Map6New.anchorPoint, zPosition: Map6New.zPosition)
        
        // Update nominal value
        var currentValue = getCurrentNominal()
        currentValue -= 900
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
    func NewMap7(){
        guard let Map7node = Map7node else { return }
        guard let BgNode = BgNode else { return }
        guard let Bnode7 = Bnode7 else { return}
        guard let nodeHarga7 = nodeHarga7 else { return }

        
        //Instantiate Node baru dari asset
        let Map7New = SKSpriteNode(imageNamed: "KodokKupu")
        //W : 363,836, H : 364,76
//        Map2New.size = Map2node.size
        
        //setup anchor point node replacement
        //kuncinya disini
        Map7New.anchorPoint = CGPoint(x:0.5, y: 0.39)
        
        //Ambil posisi map sebelumnya
        //x : 316,644, y : -227,425
        Map7New.position = Map7node.position
        Map7New.zPosition = 4
        
        //Masukkan ke childnya background
        BgNode.addChild(Map7New)
        
        //Hapus map sebelumnya
        Map7node.removeFromParent()
        Bnode7.removeFromParent()
        nodeHarga7.removeFromParent()
        
        saveMapNode(imageName: "KodokKupu", position: Map7New.position, anchorPoint: Map7New.anchorPoint, zPosition: Map7New.zPosition)
        
        // Update nominal value
//        var currentValue = Int(nominalLabel.text ?? "0") ?? 0
        var currentValue = getCurrentNominal()
        currentValue -= 150
//        nominalLabel.text = "\(currentValue)"
        saveNominalValue(currentValue)
    }
    
}
