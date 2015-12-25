//
//  Unit.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKNode {
    var ms: Int
    var hp: Int
    var bounty: Int
    var atDestination = false
    var path: [CGPoint] = []
    
    override init(){
        ms = 100
        hp = 10
        bounty = 1
        
        super.init()
        
        name = "unit"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        Move from one point to the next point
    */
    func moveAlongPath(var movePath: [CGPoint]){
        path = movePath
        if movePath.count > 0{
            let nextLocation = movePath.removeFirst()
            
            let distance = distanceBetweenPoints(position, second: nextLocation)
            let duration = durationToMove(distance, distancePerSecond: ms)
            let moveAction = SKAction.sequence([SKAction.moveTo(nextLocation, duration: duration), SKAction.runBlock({self.moveAlongPath(movePath)})])
            runAction(moveAction, withKey: GlobalConstants.keyMove)
           
        }
        else{
            atDestination = true
            removeFromParent()
        }
    }

    /**
        check if the unit is still alive
    */
    func isAlive() -> Bool{
        if hp > 0 && !atDestination{
            return true
        }
        return false
    }
    
    /**
        Unit got hit by projectile
    */
    func gotHit(projectile: Projectile){
        hp -= projectile.dmg
        
        if hp <= 0{
            removeFromParent()
        }
    }
}