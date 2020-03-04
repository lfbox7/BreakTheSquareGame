//
//  GameScene.swift
//  BreakTheSquareGame
//
//  Created by cory on 2/27/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    var underIsSeen = false
    var squareMaxHealth = 100
    var squareCurrentHealth = 100
    var coins = 0//In-game currency
    var coinWorth = 5
    var coinReward = 20
    var playerDamage = 5//5
    var damageCost = 10
    var level = 0//Counter that changes difficulty and various game aspects
    //var coinMultiplier = ["first": 4, "second": 3]//This is an experimental dictionary of multiplier values
    
    var squareBroken: SKEmitterNode!
    var gameBackground: SKSpriteNode!
    var square: SKSpriteNode!
    var player: SKSpriteNode!
    var projectile: SKSpriteNode!//Change to SKNode?
    var underSquare: SKSpriteNode!
    var damageShop: SKSpriteNode!
    var gameTimer: Timer!
    
    override func didMove(to view: SKView) {
        print((3 * (4) + 7) % 26)
        
        gameBackground = SKSpriteNode(imageNamed: "game_background")
        gameBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(gameBackground)
        gameBackground.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player_background")
        player.position = CGPoint(x: 0, y: -500)
        self.addChild(player)
        player.zPosition = 1
        
        underSquare = SKSpriteNode(imageNamed: "square_under_1")
        underSquare.position = CGPoint(x: 0, y: 300)
        self.addChild(underSquare)
        underSquare.zPosition = 0
        
        square = SKSpriteNode(imageNamed: "square")
        square.position = CGPoint(x: 0, y: 300)
        self.addChild(square)
        square.zPosition = 1
        
        projectile = SKSpriteNode(imageNamed: "projectile_1")
        projectile.position = CGPoint(x: -1000, y: -1000)
        self.addChild(projectile)
        projectile.zPosition = 2
        
        //Shrink this! Also, lengthen the player bar
        damageShop = SKSpriteNode(imageNamed: "shop_damage")
        self.addChild(damageShop)
        damageShop.position = CGPoint(x: -165, y: -500)
        damageShop.zPosition = 2
        
//        let player = AVAudioPlayer()
//        var sound = Bundle.main.path(forResource: "First Levels (Synth)", ofType: "mp3")
//        if !player.isPlaying {
//            player.play()
//        }
        
        
        
        
//        gameTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(createProjectile), userInfo: nil, repeats: true)
        createProjectile()
        createProjectile1()
        
        //Create a timer that activates once a level increase is made; for every n seconds, create a new SpriteNode of a projectile that moves down. When tapped, either have a custom health or dismiss/destroy the image/node
        
        /*
         Some notes on what is needed to do:
         Copy and paste the menus and recreate the imagery in Main.storyboard
         Add dmg+ and hlth+
         */
        
    }
    
    @objc func createProjectile() {//Creates based on timer
        projectile = SKSpriteNode(imageNamed: "projectile_1")
        projectile.position = CGPoint(x: 0, y: 0)
        self.addChild(projectile)
        projectile.zPosition = 2
        //---Here---
        print("Created")
        let random = Int.random(in: -300 ..< 300)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: random, y: 700))
        path.addLine(to: CGPoint(x: random, y: -600))
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
        //SKAction.sequence(<#T##actions: [SKAction]##[SKAction]#>)
        projectile.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: random, y: 700), duration: 37),
            SKAction.removeFromParent()
        ]))
        //        if projectile.position.y >= 300 {
        //            projectile.removeFromParent()
        //        }
        
        //projectile.run(move)
        //Destroy projectile
        
    }
    
    @objc func createProjectile1() {//Creates based on timer
        projectile = SKSpriteNode(imageNamed: "projectile_1")
        projectile.position = CGPoint(x: 0, y: 0)
        self.addChild(projectile)
        projectile.zPosition = 2
        //---Here---
        print("Created")
        let random = Int.random(in: -300 ..< 300)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: random, y: 700))
        path.addLine(to: CGPoint(x: random, y: -600))
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
        //SKAction.sequence(<#T##actions: [SKAction]##[SKAction]#>)
        projectile.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: random, y: 700), duration: 37),
            SKAction.removeFromParent()
        ]))
        //        if projectile.position.y >= 300 {
        //            projectile.removeFromParent()
        //        }
        
        //projectile.run(move)
        //Destroy projectile
        
    }
    
    func projectileMovement() {
        //After "created"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for touch: AnyObject in touches {
        
        guard let touch = touches.first else {return}
        let squareLocation = touch.location (in: self)
        let projectileLocation = touch.location(in: self)
        let damageShopLocation = touch.location(in: self)
        var projectileTapped: Bool = true
        
        if projectile.contains(projectileLocation) {
            //projectile.position = CGPoint(x: 0, y: 700)//Destroy instead of relocate
            print("Proj touched")
            projectileTapped = false
            projectile.removeFromParent()//Dismisses sprite
        }
        
        if square.contains(squareLocation) && projectileTapped {
            coins += coinWorth
            print("Coins: \(coins)")
            squareCurrentHealth -= playerDamage
            //squareHealthLabel.text = "\(squareCurrentHealth)/\(squareMaxHealth)"
            print("Health: \(squareCurrentHealth)/\(squareMaxHealth)")
            squareHealthChecker(squareHealth: squareCurrentHealth)
        }
        
        if damageShop.contains(damageShopLocation) && projectileTapped{
            if coins >= damageCost {
                coins -= damageCost
                playerDamage = Int(Double(playerDamage) + (Double(playerDamage) * (1/5)))
                damageCost = Int(Double(damageCost) + (Double(damageCost) * (2/5)))
            }
            print("Coins: \(coins); Damage: \(playerDamage); Cost for Damage: \(damageCost)")
        }
        print("-----------------------------")
        //}
    }
    
    func squareHealthChecker (squareHealth: Int) {//Could be renamed to healthChecker and take in health of all enemies
        print(squareMaxHealth)
        if squareHealth < Int(Double(squareMaxHealth) * (4.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_1")
        }
        if squareHealth < Int(Double(squareMaxHealth) * (3.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_2")
        }
        if squareHealth < Int(Double(squareMaxHealth) * (2.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_3")
        }
        if squareHealth < Int(Double(squareMaxHealth) * (1.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_4")
        }
        
        if squareHealth <= 0 {
            coins += coinReward
            level += 1
            square.texture = SKTexture(imageNamed: "square")
            levelIncrease()
            print("\(level)")
            //Call a function that does a short animation involving what's underneath the square
            underIsSeen = true
            //print("\(underIsSeen)")
            theUnderneath()
            
        }
        
        
    }
    
    func levelIncrease () {
        squareMaxHealth = Int(Double(squareMaxHealth) + (Double(squareMaxHealth) * 0.55))//0.25 is a temporary increase
        squareCurrentHealth = squareMaxHealth
        
        //underIsSeen = true
        //theUnderneath()
    }
    
    func theUnderneath() {
        //let showBelowTimer: Timer!
        if level == 3 && underIsSeen == true {
            underSquare.texture = SKTexture(imageNamed: "square_under_1")
            square.isHidden = true
            square.position = CGPoint(x: 0, y: 5000)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (Timer) in
                self.square.isHidden = false
                self.square.position = CGPoint(x: 0, y: 300)
            })
            underIsSeen = false
            
        } else if level == 4 && underIsSeen == true{
            underSquare.texture = SKTexture(imageNamed: "square_under_2")
            square.isHidden = true
            square.position = CGPoint(x: 0, y: 5000)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (Timer) in
                self.square.isHidden = false
                self.square.position = CGPoint(x: 0, y: 300)
            })
            underIsSeen = false
            
        } else if level == 5 && underIsSeen == true{
            underSquare.texture = SKTexture(imageNamed: "square_under_3")
            square.isHidden = true
            square.position = CGPoint(x: 0, y: 5000)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (Timer) in
                self.square.isHidden = false
                self.square.position = CGPoint(x: 0, y: 300)
            })
            underIsSeen = false
            print("Projectiles start")
            
        }
    }
    
    //    @objc func sendProjectile() {//Used directly from tutorial of Brian
    //        let projectilePos = GKRandomDistribution(lowestValue: 0, highestValue: 300)
    //        let position = CGFloat(projectilePos.nextInt())
    //
    //        projectile.position = CGPoint(x: position, y: self.frame.size.height + projectile.size.height)
    //
    //        self.addChild(projectile)
    //
    //        let animatedDuration: TimeInterval = 6
    //        var actionArray = [SKAction]()
    //        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -projectile.size.height), duration: animatedDuration))
    //        actionArray.append(SKAction.removeFromParent())
    //
    //        projectile.run(SKAction.sequence(actionArray))
    //    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //        if projectile.position.y >= 300 {
        //            projectile.removeFromParent()
        //        }
    }
}

/*
 The following are some tutorials used to build the sprites and environments of the game:
 "SpriteKit Particle Emitters - Swift - Xcode 10" by Sean Allen
 "iOS Swift Game Tutorial: SpriteKit Space Game (with Explosions)" by Brian Advent
 Paul Hudson
 
 "" by
 */
