//
//  SquareTower.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class SquareTower: Tower {
    override init() {
        super.init()
        
        attackspeed = 0.5
        
        let node = SKShapeNode(rectOfSize: CGSizeMake(20, 20))
        node.fillColor = UIColor.darkGrayColor()
        
        addChild(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
        this tower shoots simpleprojectiles
    */
    override func getProjectile() -> Projectile {
        return SimpleProjectile()
    }
}