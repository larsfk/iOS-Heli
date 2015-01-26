//
//  GameViewController.swift
//  Helicopter_task3
//
//  Created by Lars Klingenberg on 21.01.15.
//  Copyright (c) 2015 Lars Klingenberg. All rights reserved.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: self.view.bounds.size)
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}