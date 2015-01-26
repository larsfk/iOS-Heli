//
//  GameScene.swift
//  Helicopter_task3
//
//  Created by Lars Klingenberg on 21.01.15.
//  Copyright (c) 2015 Lars Klingenberg. All rights reserved.
//

import SpriteKit
import Darwin

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Player       : UInt32 = 0b1      // 1
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let sheet = Heli()
    let pi = CGFloat(M_PI)
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // Sets the world to be a physical world with gravity 0 and can have collitions (two physical bodies)
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        runAction(SKAction.repeatAction(SKAction.runBlock(addHeli), count: 2))
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) //0xFFFFFFFF = 32 bit
    }
    
    func random() -> Int {
        return Int(Float(arc4random()) / 0xFFFFFFFF) //0xFFFFFFFF = 32 bit
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    func randomInt() -> UInt32{
        var num = arc4random_uniform(10)
        return num
    }
    
    func addHeli(){
        
        let player = SKSpriteNode(texture: sheet.heli_1())
        
        player.position = CGPoint(x: player.size.width / 2, y: size.height / 2)
        
        addChild(player)
        
        var fly = SKAction.animateWithTextures(sheet.heli_fly(), timePerFrame: 0.1)
        var flyAnim = SKAction.repeatAction(fly, count: Int(randomInt()))
        
        var flyRight = SKAction.moveToX(size.width, duration: flyAnim.duration)
        var flyLeft = SKAction.moveToX(0, duration: flyAnim.duration)
        
        var mirrorDirection = SKAction.scaleXTo(1, y:1, duration: 0.0)
        var resetDirection  = SKAction.scaleXTo(-1,  y:1, duration:0.0)
        
        var flyAndMoveRight = SKAction.group([resetDirection,flyAnim,flyRight])
        var flyAndMoveLeft = SKAction.group([mirrorDirection, flyAnim,flyLeft])
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)  // Create a physical body 4 the sprite (rectangle)
        player.physicsBody?.dynamic = true                                 // Dynamic -> you code motion, not the engine
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player      // Sets category bit mask to be monsterCategory
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Player // Which object to listen to (collition)
        player.physicsBody?.collisionBitMask = PhysicsCategory.None        // Which objects should bounce of player
        
        player.runAction(SKAction.repeatActionForever(SKAction.sequence([flyAndMoveRight,flyAndMoveLeft])))
    }
    
    // Removes the monster and the projectile when hit
    func playerDidCollideWithPlayer(player1: SKSpriteNode, player2: SKSpriteNode){
        println("Hit")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Sets the two objects that will collide and sort them out
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Checks if its the monster and the projectile thats colliding, and then make the call!
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Player != 0)) {
                playerDidCollideWithPlayer(firstBody.node as SKSpriteNode, player2: secondBody.node as SKSpriteNode)
        }
        
    }
    
    
//        func moveHeli() {
//    
//            // Determine speed
//            let actualSpeed = CGFloat(2.0)
//    
//            // Random Y axis
//            let acutalY_1 = random(min: player.size.height/2, max: size.height - player.size.height/2)
//            let acutalY_2 = random(min: player.size.height/2, max: size.height - player.size.height/2)
//    
//    
//            // Create action
//            let rightPoint = CGPoint(x: size.width - player.size.width / 2, y: acutalY_1)
//            let actionMoveRight = SKAction.moveTo(rightPoint, duration: NSTimeInterval(actualSpeed))
//    
//            let leftPoint = CGPoint(x: 0, y: acutalY_2)
//            let actionMoveLeft = SKAction.moveTo(leftPoint, duration: NSTimeInterval(actualSpeed))
//    
//            let moveToPoint = CGPoint(x: point.x, y: point.y)
//            let actionMoveToPoint = SKAction.moveTo(point, duration: NSTimeInterval(actualSpeed))
//    
//            player.runAction(SKAction.sequence([rotation(from: player.position, to: moveToPoint), actionMoveToPoint]))
//            
//        }
    
    
    
    
    
    
}
