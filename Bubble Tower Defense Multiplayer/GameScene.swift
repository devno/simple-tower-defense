//
//  GameScene.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright (c) 2015 Voglhuber. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    //Path the units follow
    let path = [CGPoint(x: 100, y: 100), CGPoint(x: 400, y: 100), CGPoint(x: 400, y: 500), CGPoint(x: 100, y: 500), CGPoint(x: 100, y: 900), CGPoint(x: 400, y: 900)]
    let cameraNode = SKCameraNode()
    var moveTouch: UITouch?
    var isMoving = false
    var moveStarted: CGPoint?
    var buildTower: Tower?
    
    
    /**
        init the gamescene
    */
    override func didMoveToView(view: SKView) {
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cameraNode)
        scene?.camera = cameraNode
        
        //Spawn a unit
        let spawnAction = SKAction.runBlock({
            let unit = RoundUnit()
            unit.position = self.path.first!
            
            unit.moveAlongPath(self.path)
            
            self.addChild(unit)
        })
        
        //Run the spawn action every 3 seconds
        let repeatAction = SKAction.sequence([spawnAction, SKAction.waitForDuration(3.0)])
        
        runAction(SKAction.repeatActionForever(repeatAction))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            buildTower = SquareTower()
            buildTower!.position = location
            addChild(buildTower!)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        checkTowersToAttack()
    }
    
    /**
        Check all towers if there are units in range to attack
    */
    func checkTowersToAttack(){
        //Check for each tower if a unit is in range
        enumerateChildNodesWithName("tower", usingBlock: { (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if let tower = node as? Tower{
                self.attackUnitsInRange(tower)
            }
        })
    }
    
    
    /**
        Check if a tower can attack and if there is a unit in range
    */
    func attackUnitsInRange(tower: Tower){
        if tower.canAttack && !tower.hasTarget{
            self.enumerateChildNodesWithName("unit") { (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
                if let unit = node as? Unit{
                    if tower.distanceToNode(unit) < tower.range{
                        tower.attack(unit)
                    }
                }
            }
        }
    }
}
