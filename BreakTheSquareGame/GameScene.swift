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
    var playerMaxHealth = 100
    var playerCurrentHealth = 100
    var coins = 0//In-game currency
    var coinWorth = 5
    var coinReward = 20
    var playerDamage = 20//5
    var damageCost = 10
    var level = 0//Counter that changes difficulty and various game aspects
    //var coinMultiplier = ["first": 4, "second": 3]//This is an experimental dictionary of multiplier values
    var projectileDamage = 5//Will change based on level
    
    var squareBroken: SKEmitterNode!//An emitter animation for breaking the square
    var gameBackground: SKSpriteNode!//The background of the game
    var square: SKSpriteNode!//The square to tap
    var player: SKSpriteNode!//The player
    //var projectile: SKSpriteNode!//A projectile (Change to SKNode?)
    var underSquare: SKSpriteNode!//What is underneath the square???
    var damageShop: SKSpriteNode!//Increases damage
    var gameTimer: Timer!//A timer
    //UserDefaults.standard.set(false, forKey: "isLoggedIn")
    
    private var counter = 1
    private var hit = 0
    //private var doodle: [SKSpriteNode]!
    private var (doodle0, doodle1, doodle2, doodle3, doodle4, doodle5, doodle6, doodle7, doodle8, doodle9, doodle10, doodle11, doodle12,doodle13, doodle14, doodle15, doodle16, doodle17, doodle18, doodle19, doodle20) = (SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"))
    private var projectiles: [SKSpriteNode]!
    var aPlayer = AVAudioPlayer()//Audio player
    
    /*
     Contains the creation of sprites
     */
    override func didMove(to view: SKView) {
        gameBackground = SKSpriteNode(imageNamed: "game_background")
        gameBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(gameBackground)
        gameBackground.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player_background")
        player.position = CGPoint(x: 0, y: -500)
        self.addChild(player)
        player.zPosition = 1
        player.name = "player"
        
        underSquare = SKSpriteNode(imageNamed: "square_under_1")
        underSquare.position = CGPoint(x: 0, y: 300)
        self.addChild(underSquare)
        underSquare.zPosition = 0
        
        square = SKSpriteNode(imageNamed: "square")
        square.position = CGPoint(x: 0, y: 300)
        self.addChild(square)
        square.zPosition = 1
        
        projectiles = [doodle0, doodle1, doodle2, doodle3, doodle4, doodle5, doodle6, doodle7, doodle8, doodle9, doodle10, doodle11, doodle12, doodle13, doodle14, doodle15, doodle16, doodle17, doodle18, doodle19, doodle20]
//        isCreated = [isCreated1, isCreated2, isCreated3, isCreated4, isCreated5, isCreated6, isCreated7, isCreated8, isCreated9, isCreated10, isCreated11, isCreated12, isCreated13, isCreated14, isCreated15, isCreated16, isCreated17, isCreated18, isCreated19, isCreated20]
        projectiles[0] = SKSpriteNode(imageNamed: "projectile_1")
        projectiles[0].position = CGPoint(x: -100000, y: -100000)
        self.addChild(projectiles[0])
        projectiles[0].zPosition = 1
        
        
        
        //gameTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(moving), userInfo: nil, repeats: true)
        
        //Shrink this image! Also, lengthen the player bar and add some labels
        damageShop = SKSpriteNode(imageNamed: "shop_damage")
        self.addChild(damageShop)
        damageShop.position = CGPoint(x: -165, y: -500)
        damageShop.zPosition = 2
        
        /*
        let sound = Bundle.main.path(forResource: "First Levels (Synth)", ofType: "mp3")
        do {
            aPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("Error with music")

        }
 */
        
        //Create a timer that activates once a level increase is made; for every n seconds, create a new SpriteNode of a projectile that moves down. When tapped, either have a custom health or dismiss/destroy the image/node
        
        /*
         Some notes on what is needed to do:
         Copy and paste the menus and recreate the imagery in Main.storyboard
         Add dmg+ and hlth+
         */
        
    }
    
    @objc func moving() {
        let removeDoodle = SKAction.removeFromParent()
        //let bol = true
        while counter <= 20{
            //Create an if... that checks for existence; if it does, do nothing (cause for... to run again; else, do the code and break)
            //if isCreated[counter] == false {
            projectiles[counter] = SKSpriteNode(imageNamed: "projectile_1")
            projectiles[counter].position = CGPoint(x: 0, y: 0)
            self.addChild(projectiles[counter])
            projectiles[counter].zPosition = 2//Prev 1
            projectiles[counter].name = "projectile"
            
            print("Created")
            let random = Int.random(in: -300 ..< 300)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: random, y: 700))
            path.addLine(to: CGPoint(x: random, y: -600))
            let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
            
            projectiles[counter].run(SKAction.sequence([
                move,
                removeDoodle
            ]))
            //isCreated[counter] = true
            if counter >= 20 {
                counter = 1
            }
            counter += 1
            break
            //}
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for touch: AnyObject in touches {
        
        guard let touch = touches.first else {return}
        let squareLocation = touch.location (in: self)
        let projectileLocation = touch.location(in: self)
        let damageShopLocation = touch.location(in: self)
        var projectileTapped: Bool = true
        
//        if projectile.contains(projectileLocation) {
//            //projectile.position = CGPoint(x: 0, y: 700)//Destroy instead of relocate
//            print("Proj touched")
//            projectileTapped = false
//            projectile.removeFromParent()//Dismisses sprite
//        }
        
        for projectile in projectiles{
            //let touchLocation = touch.location(in: self)
            
            if projectile.contains(projectileLocation) {
                projectile.position = CGPoint(x: -100000, y: -100000)//Temp solution?
                projectile.removeFromParent()
                print("Doodle broken")
                projectileTapped = false
            }
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
            gameTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(moving), userInfo: nil, repeats: true)
        }
    }
    
    func playerHealthChecker() {
        if playerCurrentHealth <= 0 {
            //End game
            print("End game")
            //Return to main menu, add coins, check death total to reveal new abilities and unlock tutorial
        }
    }
    
    func collisions() {
        for counter in 1...20 {
            
            if projectiles[counter].intersects(player) {//Seems to be inconsistent
                projectiles[counter].position = CGPoint(x: -100000, y: -100000)
                projectiles[counter].removeFromParent()
                hit += 1
                print("Player was hit\(hit)")
                playerCurrentHealth -= projectileDamage
                print("\(playerCurrentHealth) / \(playerMaxHealth)")
            }
        }
    }
    
    /*
     This may be relocated; makes sure the music is playing throughout the game (should change based on visible attacks)
     */
    override func update(_ currentTime: TimeInterval) {
        collisions()
        playerHealthChecker()
        /*
        if !aPlayer.isPlaying {
            aPlayer.play()
        }
 */
    }
}

/*
 The following are some tutorials used to build the sprites and environments of the game:
 "SpriteKit Particle Emitters - Swift - Xcode 10" by Sean Allen
 "iOS Swift Game Tutorial: SpriteKit Space Game (with Explosions)" by Brian Advent
 Paul Hudson
 
 "" by
 */
