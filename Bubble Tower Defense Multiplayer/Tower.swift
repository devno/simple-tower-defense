//
//  Tower.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class Tower: SKNode {
    var attackspeed: Double
    var range: Float
    var dmg: Double
    var canAttack: Bool = true
    var hasTarget: Bool = false
    
    override init() {
        attackspeed = 1.0
        range = 100
        dmg = 1
        
        super.init()
        
        name = "tower"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        attack a unit
    */
    func attack(unit: Unit){
        if canAttack{
            //Check if target is still alive and in range
            if !unit.isAlive() || distanceToNode(unit) > range{
                hasTarget = false
                return
            }
            let projectile = getProjectile()
            projectile.position = position
            self.parent?.addChild(projectile)
            projectile.followNode(unit)
            
            canAttack = false
            
            let attackAction = SKAction.sequence([SKAction.waitForDuration(attackspeed), SKAction.runBlock({self.readyToAttack()})])
            
            runAction(attackAction)
        }
        
    }
    
    /**
        the tower is ready to attack again
    */
    func readyToAttack(){
        canAttack = true
    }
    
    /**
     returns the projectile of the tower
    */
    func getProjectile() -> Projectile{
        return Projectile()
    }

}