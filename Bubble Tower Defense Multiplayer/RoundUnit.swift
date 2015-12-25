//
//  RoundUnit.swift
//  Bubble Tower Defense Multiplayer
//
//  Created by Roman Voglhuber on 23/12/15.
//  Copyright © 2015 Voglhuber. All rights reserved.
//

import Foundation
import SpriteKit

class RoundUnit: Unit {
    
    override init() {
        super.init()
        
        let node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = UIColor.grayColor()
        
        addChild(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}