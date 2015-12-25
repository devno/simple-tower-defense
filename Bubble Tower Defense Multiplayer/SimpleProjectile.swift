//
//  SimpleProjectile.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class SimpleProjectile: Projectile {
    override init() {
        super.init()
        
        let node = SKShapeNode(circleOfRadius: 3)
        node.fillColor = UIColor.blackColor()
        node.strokeColor = UIColor.clearColor()
        
        addChild(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}