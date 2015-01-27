//
//  GameScene.swift
//  Helicopter_task3
//
//  Created by Lars Klingenberg on 21.01.15.
//  Copyright (c) 2015 Lars Klingenberg. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Player       : UInt32 = 0x1 << 1
    static let LeftEdge     : UInt32 = 0x1 << 2
    static let RightEdge    : UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Initialize players as helicopters
    let player1 = SKSpriteNode(texture: Heli().heli_1())
    let player2 = SKSpriteNode(texture: Heli().heli_1())
    let player3 = SKSpriteNode(texture: Heli().heli_1())
    let player4 = SKSpriteNode(texture: Heli().heli_1())

    
    override func didMoveToView(view: SKView) {
        // Sets background color
        backgroundColor = SKColor.whiteColor()
        
        /* World */
        // Physics
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        self.physicsBody?.friction = 0.0
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        // Contact
        self.physicsWorld.contactDelegate = self
        
        // Add walls
        addWalls()
        
        // Add helicopters
        addHeli(player1)
        addHeli(player2)
        addHeli(player3)
        addHeli(player4)
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
    
    // Adds helicopter
    func addHeli(player: SKSpriteNode){
        
        // Random variables to make the player spawn on a random spot
        let x = self.random(min: CGFloat(10), max: CGFloat(500))
        let y = self.random(min: CGFloat(10), max: CGFloat(500))
        
        
        /* Player */
        player.position = CGPoint(x: x, y: y)
        addChild(player)
        player.setScale(1.5)
        
        // Physics
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)  // Create a physical body 4 the sprite (rectangle)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.frame.size.height/2)
        player.physicsBody?.friction = 0.0
        player.physicsBody?.restitution = 1.0
        player.physicsBody?.linearDamping = 0.0
        player.physicsBody?.angularDamping = 0.0
        player.physicsBody?.allowsRotation = true
        
        // Contact
        player.physicsBody!.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        
        // Freeze the helicopter, then shoot it in a direciton
        player.physicsBody?.velocity = CGVectorMake(0,0) // Freeze the helicopter
        player.physicsBody?.applyImpulse(CGVectorMake(-5,-5)) // Shoots the helicopter in a direction

        
        // Adds animation to the helicopter
        player.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(Heli().heli_fly(), timePerFrame: 0.1)))

    }
    
    // Adds walls
    func addWalls(){
        /* Left */
        let leftRect = CGRectMake(frame.origin.x, frame.origin.y, 1, frame.size.height)
        let leftEdge = SKNode()
        addChild(leftEdge)
        
        // Physics
        leftEdge.physicsBody = SKPhysicsBody(edgeLoopFromRect: leftRect)
        
        // Contact
        leftEdge.physicsBody!.categoryBitMask = PhysicsCategory.LeftEdge
        leftEdge.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        
        
        /* Right */
        let rightRect = CGRectMake(frame.size.width,frame.origin.y, 1,frame.size.height )
        let rightEdge = SKNode()
        addChild(rightEdge)
        
        // Physics
        rightEdge.physicsBody = SKPhysicsBody(edgeLoopFromRect: rightRect)
        
        // Contact
        rightEdge.physicsBody!.categoryBitMask = PhysicsCategory.RightEdge
        rightEdge.physicsBody?.contactTestBitMask = PhysicsCategory.Player

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
        
        // Helicopter hits left egde -> flips the sprite
        if firstBody.categoryBitMask == PhysicsCategory.Player && secondBody.categoryBitMask == PhysicsCategory.LeftEdge {
            println("Hit LeftEdge")
            var player = firstBody.node as SKSpriteNode
            player.runAction(SKAction.scaleXTo(-1.5, y: 1.5, duration: 0.0))

        }
        // Helicopter hits right egde -> flips the sprite
        if firstBody.categoryBitMask == PhysicsCategory.Player && secondBody.categoryBitMask == PhysicsCategory.RightEdge {
            println("Hit RightEdge")
            var player = firstBody.node as SKSpriteNode
            player.runAction(SKAction.scaleXTo(1.5, y: 1.5, duration: 0.0))
        }
        
        // Checks if two helicopters collide and then calls a function
        if ((firstBody.categoryBitMask == PhysicsCategory.Player) &&
            (secondBody.categoryBitMask == PhysicsCategory.Player)) {
                playerDidCollideWithPlayer(firstBody.node as SKSpriteNode, player2: secondBody.node as SKSpriteNode)
        }
    }
    
    // Flips the sprite after they collide
    func playerDidCollideWithPlayer(player1: SKSpriteNode, player2: SKSpriteNode){
        player1.runAction(SKAction.scaleXTo(player1.xScale * -1, y: 1.5, duration: 0.0))
        player2.runAction(SKAction.scaleXTo(player2.xScale * -1, y: 1.5, duration: 0.0))
    }
}
