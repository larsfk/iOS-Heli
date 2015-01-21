//
//  GameScene.swift
//  Helicopter
//
//  Created by Lars Klingenberg on 18.01.15.
//  Copyright (c) 2015 Lars Klingenberg. All rights reserved.
//

import SpriteKit
import Darwin

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "Cobra")
    
    let pi = CGFloat(M_PI)

    
    override func didMoveToView(view: SKView) {
        
        player.xScale = 0.2
        player.yScale = 0.2
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        player.runAction(SKAction.rotateToAngle(CGFloat(-pi/2), duration: 0.0))
        
        addChild(player)
        
        backgroundColor = SKColor.whiteColor()
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(moveHeli), SKAction.waitForDuration(4.0)])))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) //0xFFFFFFFF = 32 bit
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    func moveHeli() {
        
        // Determine speed
        let actualSpeed = CGFloat(2.0)
        
        // Random Y axis
        let acutalY_1 = random(min: player.size.height/2, max: size.height - player.size.height/2)
        let acutalY_2 = random(min: player.size.height/2, max: size.height - player.size.height/2)
        
        // Create action
        let rightPoint = CGPoint(x: size.width - player.size.width / 2, y: acutalY_1)
        let actionMoveRight = SKAction.moveTo(rightPoint, duration: NSTimeInterval(actualSpeed))
        
        let leftPoint = CGPoint(x: 0, y: acutalY_2)
        let actionMoveLeft = SKAction.moveTo(leftPoint, duration: NSTimeInterval(actualSpeed))
        
        player.runAction(SKAction.sequence([rotation(from: player.position, to: rightPoint), actionMoveRight, rotation(from: rightPoint, to: leftPoint), actionMoveLeft]))
        
    }
    
    func rotation(from pointA: CGPoint, to pointB: CGPoint) -> SKAction{
        
        var angle = atan2(pointB.y - pointA.y, pointB.x - pointA.x)
        
        return SKAction.rotateToAngle(angle + 3*pi/2, duration: 0)
        
        
    }
    
    
}
