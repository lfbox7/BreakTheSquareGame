//
//  GameScene.swift
//  BreakTheSquareGame
//
//  Created by cory on 2/27/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var squareMaxHealth = 100
    var squareCurrentHealth = 100
    var coins = 0//In-game currency
    var coinWorth = 5
    var coinReward = 20
    var playerDamage = 5
    var level = 0//Counter that changes difficulty and various game aspects
    //var coinMultiplier = ["first": 4, "second": 3]//This is an experimental dictionary of multiplier values
    
    var squareBroken: SKEmitterNode!
    var gameBackground: SKSpriteNode!
    var square: SKSpriteNode!
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        //squareBroken = SKEmitterNode
        gameBackground = SKSpriteNode(imageNamed: "game_background")
        gameBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(gameBackground)
        gameBackground.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player_background")
        player.position = CGPoint(x: 0, y: -500)
        self.addChild(player)
        
        square = SKSpriteNode(imageNamed: "square")
        square.position = CGPoint(x: 0, y: 300)
        self.addChild(square)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location (in: self)
        
        if square.contains(touchLocation) {
            coins += coinWorth
            print("Coins: \(coins)")
            squareCurrentHealth -= playerDamage
            //squareHealthLabel.text = "\(squareCurrentHealth)/\(squareMaxHealth)"
            print("Health: \(squareCurrentHealth)/\(squareMaxHealth)")
            squareHealthChecker(squareHealth: squareCurrentHealth)
        }
    }
    
    func squareHealthChecker (squareHealth: Int) {//Could be renamed to healthChecker and take in health of all enemies
        
        //Insert an if statement to change sqaure image based on remaining health
        if squareHealth <= 0 {
            coins += coinReward
            level += 1
            levelIncrease()
            //Call a function that does a short animation involving what's underneath the square
        }
    }
    
    func levelIncrease () {
        squareMaxHealth = Int(Double(squareMaxHealth) + (Double(squareMaxHealth) * 0.25))//0.25 is a temporary increase
        squareCurrentHealth = squareMaxHealth
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

/*
 The following are some tutorials used to build the sprites and environments of the game:
 "SpriteKit Particle Emitters - Swift - Xcode 10" by Sean Allen
 "iOS Swift Game Tutorial: SpriteKit Space Game (with Explosions)" by Brian Advent
 "" by
 */
