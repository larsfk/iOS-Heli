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
    let label = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView) {
        
        player.xScale = 0.2
        player.yScale = 0.2
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        //player.runAction(SKAction.rotateToAngle(CGFloat(-pi/2), duration: 0.0))
        
        addChild(player)
        
        backgroundColor = SKColor.whiteColor()

        label.text = String(format: "x: %.1f , y: %.1f", Double(player.position.x),Double(player.position.y) )
        label.fontSize = 10
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width / 10 , y: size.height / 1.05)
        addChild(label)

        
        
        //Physics
        physicsWorld.gravity = CGVectorMake(0, 0)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.dynamic = true
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
        //runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(moveHeli), SKAction.waitForDuration(4.0)])))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) //0xFFFFFFFF = 32 bit
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    //Rotation på helikoptret
    func rotation(from pointA: CGPoint, to pointB: CGPoint) -> SKAction{
        
        var angle = atan2(pointB.y - pointA.y, pointB.x - pointA.x)
        
        return SKAction.rotateToAngle(angle + 2*pi, duration: 0)
        
        
    }
    
    func updateText(){
        // Add Text
        var x = player.position.x
        var y = player.position.y
        label.text = String(format: "x: %.1f , y: %.1f", Double(x),Double(y))

    }
    
    // Touch funksjonalitet
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        // Touch
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self) as CGPoint
        
        let actualSpeed = CGFloat(2.0)
        
        let actionMoveToPoint = SKAction.moveTo(touchLocation, duration: NSTimeInterval(actualSpeed))
        
        let sizeChange = SKAction.scaleTo(random(min: 0.1, max: 0.3), duration: 1)
        
        updateText()

        player.runAction(SKAction.sequence([sizeChange,rotation(from: player.position, to: touchLocation), actionMoveToPoint]))
        
    }
    
    
//    func moveHeli() {
//        
//        // Determine speed
//        let actualSpeed = CGFloat(2.0)
//        
//        // Random Y axis
//        //let acutalY_1 = random(min: player.size.height/2, max: size.height - player.size.height/2)
//        //let acutalY_2 = random(min: player.size.height/2, max: size.height - player.size.height/2)
//        
//        
//        // Create action
//        //let rightPoint = CGPoint(x: size.width - player.size.width / 2, y: acutalY_1)
//        //let actionMoveRight = SKAction.moveTo(rightPoint, duration: NSTimeInterval(actualSpeed))
//        
//        //let leftPoint = CGPoint(x: 0, y: acutalY_2)
//        //let actionMoveLeft = SKAction.moveTo(leftPoint, duration: NSTimeInterval(actualSpeed))
//        
//        let moveToPoint = CGPoint(x: point.x, y: point.y)
//        let actionMoveToPoint = SKAction.moveTo(point, duration: NSTimeInterval(actualSpeed))
//        
//        player.runAction(SKAction.sequence([rotation(from: player.position, to: moveToPoint), actionMoveToPoint]))
//        
//    }
    

    

    
    
}
