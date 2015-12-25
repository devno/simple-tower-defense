//
//  Projectile.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: SKNode {
    var ms: Int
    var dmg: Int
    
    override init() {
        ms = 500
        dmg = 1
        
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        follow a node until it is hit
    */
    func followNode(unit: Unit){
        var location = unit.position
        
        //Check if the unit is still alive
        if !unit.isAlive(){
            removeFromParent()
        }
        
        //If the distance is small enough, the target is hit
        if distanceTo(location) < 30{
            hitTarget(unit)
            return
        }
        
        //Follow node if distance is too big
        if  distanceToNode(unit) > 50 {
            location = midPointToNode(unit, percentage: 0.9)
        }
        
        let distance = distanceBetweenPoints(position, second: location)
        let duration = durationToMove(distance, distancePerSecond: ms)
        
        let followAction = SKAction.sequence([SKAction.moveTo(location, duration: duration), SKAction.runBlock({self.followNode(unit)})])
        
        runAction(followAction)
    }
    
    /**
        Projectile hit the target
    */
    func hitTarget(unit: Unit){
        unit.gotHit(self)
        removeFromParent()
    }
}