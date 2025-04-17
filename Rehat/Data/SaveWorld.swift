//
//  SaveWorld.swift
//  Rehat
//
//  Created by Syafrie Bachtiar on 23/06/24.
//

import CoreData
import SpriteKit

func saveMapNode(imageName: String, position: CGPoint, anchorPoint: CGPoint, zPosition: CGFloat) {
    let context = PersistenceController.shared.container.viewContext
    
    guard let entity = NSEntityDescription.entity(forEntityName: "MapNode", in: context) else {
        print("Could not find entity description for MapNode")
        return
    }
    let newNode = NSManagedObject(entity: entity, insertInto: context)

    newNode.setValue(imageName, forKey: "imageName")
    newNode.setValue(Double(position.x), forKey: "positionX")
    newNode.setValue(Double(position.y), forKey: "positionY")
    newNode.setValue(Double(anchorPoint.x), forKey: "anchorPointX")
    newNode.setValue(Double(anchorPoint.y), forKey: "anchorPointY")
    newNode.setValue(Double(zPosition), forKey: "zPosition")

    do {
        try context.save()
        print("Node saved successfully: \(newNode)")
    } catch {
        print("Failed saving node: \(error)")
    }
}


func loadMapNodes() -> [SKSpriteNode] {
    let context = PersistenceController.shared.container.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MapNode")

    do {
        let result = try context.fetch(request)
        var nodes: [SKSpriteNode] = []
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
            node.zPosition = CGFloat(zPosition)

            nodes.append(node)
            print("Node loaded: \(node)")
        }
        return nodes
    } catch {
        print("Failed loading")
        return []
    }
}
