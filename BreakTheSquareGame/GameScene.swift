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

class GameScene: SKScene{
    //var game: GameData = GameData()
    //let red, green, blue: Double
    
    //var val: Int = 4
    
    var underIsSeen = false
    var squareMaxHealth = 100
    var squareCurrentHealth = 100
    var playerMaxHealth = 500//100
    var playerCurrentHealth = 500//100
    var coins = 0//In-game currency
    var coinWorth = 5
    var coinReward = 20
    var playerDamage = 50//5
    var damageCost = 10
    var level = 0//Counter that changes difficulty and various game aspects
    var projectileDamage = 5//Will change based on level
    var playerDeaths = 0
    var isGamePaused = false
    var menus: MenuViewController!//Is incorrect
    var checker: Bool = true//This statement will be outside, or in a UserDefault
    
    var squareBroken: SKEmitterNode!//An emitter animation for breaking the square
    var gameBackground: SKSpriteNode!//The background of the game
    var square: SKSpriteNode!//The square to tap
    var player: SKSpriteNode!//The player
    var underSquare: SKSpriteNode!//What is underneath the square???
    var damageShop: SKSpriteNode!//Increases damage
    var projectileTimer: Timer!//A timer
    var bloomTimer: Timer!
    var positionsX = [Int?](repeating: 0, count: 20)//Creates an array of size 20 filled with nils
    var positionsY = [Int?](repeating: 0, count: 20)
    var someCount = 0
    
    var projCounter = 1//Loops the projectiles
    var bloomCounter = 0//Loops the blooms
    var hit = 0//Tests if player is hit
    
    var (doodle0, doodle1, doodle2, doodle3, doodle4, doodle5, doodle6, doodle7, doodle8, doodle9, doodle10, doodle11, doodle12,doodle13, doodle14, doodle15, doodle16, doodle17, doodle18, doodle19, doodle20) = (SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"))
    var projectiles: [SKSpriteNode] = []
    
    var (bloom0, bloom1, bloom2, bloom3, bloom4, bloom5, bloom6, bloom7, bloom8, bloom9, bloom10) = (SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"))
    //var (t1, t2, t3, t4, t5, t6, t7, t8, t9, t10) = (Timer(), Timer(), Timer(), Timer(), Timer(), Timer(), Timer(), Timer(), Timer(), Timer())
    var blooms: [SKSpriteNode] = []
    var bloomCountDown: Timer!
    var bloomTimers: [Timer] = []
    //var bloomTimer: Timer!
    var (timed1, timed2, timed3, timed4, timed5, timed6, timed7, timed8, timed9, timed10) = (0,0,0,0,0,0,0,0,0,0)
    var times: [Int] = []
    var timed = 0
    var timeInterval = 5.0
    var bloomDmgMult = 1
    //private let scene: GameScene = GameScene()
    //var scene: GameScene! = nil
    //    var val2: Int!
    //    var value: Int = 16
    //    var array: [Int] = []
    
    var aPlayer = AVAudioPlayer()//Audio player
    
    private let files: GameFiles = GameFiles()
    
    override func didMove(to view: SKView) {
        var sometimers: [Timer] = []
        var timed: Timer
        for count in 0..<3{
            timed = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
                print("Something")
            }
            sometimers.append(timed)
        }
        print("Total: \(sometimers.count)")
        sometimers.remove(at: sometimers.count - 1).invalidate()
        sometimers.remove(at: sometimers.count - 1).invalidate()
        sometimers.remove(at: sometimers.count - 1).invalidate()
        //sometimers.remove(at: 0)
        print("Total: \(sometimers.count)")
        
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
        
        projectiles.append(contentsOf: [doodle0, doodle1, doodle2, doodle3, doodle4, doodle5, doodle6, doodle7, doodle8, doodle9, doodle10, doodle11, doodle12, doodle13, doodle14, doodle15, doodle16, doodle17, doodle18, doodle19, doodle20])
        
        projectiles[0] = SKSpriteNode(imageNamed: "projectile_1")
        projectiles[0].position = CGPoint(x: -100000, y: -100000)
        self.addChild(projectiles[0])
        projectiles[0].zPosition = 1
        
        
        
        blooms = [bloom0, bloom1, bloom2, bloom3, bloom4, bloom5, bloom6, bloom7, bloom8, bloom9, bloom10]
        times = [timed1, timed2, timed3, timed4, timed5, timed6, timed7, timed8, timed9, timed10]
        //bloomTimers = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10]
        
        //Shrink this image! Also, lengthen the player bar and add some labels
        damageShop = SKSpriteNode(imageNamed: "shop_damage")
        self.addChild(damageShop)
        damageShop.position = CGPoint(x: -165, y: -500)
        damageShop.zPosition = 3
        
        preparation()
        
        if level >= 5 {
            projectileTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(projectileMovement), userInfo: nil, repeats: true)
        }
        
        bloomCountDown = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(bloomCreation), userInfo: nil, repeats: true)
    }
    
    func preparation() {//Left in here to set standard defaults
        
        setUserDefaults()//Used to reset values back to default; will be controlled by button in credits
        
        UserDefaults.standard.set(isGamePaused, forKey: "isGamePaused")//Might not belong here
        
        if UserDefaults.standard.object(forKey: "playerDeaths") != nil {
            playerDeaths = UserDefaults.standard.object(forKey: "playerDeaths") as! Int
        }
        if UserDefaults.standard.object(forKey: "underIsSeen") != nil {
            underIsSeen = UserDefaults.standard.object(forKey: "underIsSeen") as! Bool
        }
        if UserDefaults.standard.object(forKey: "squareMaxHealth") != nil {
            squareMaxHealth = UserDefaults.standard.object(forKey: "squareMaxHealth") as! Int
        }
        if UserDefaults.standard.object(forKey: "squareCurrentHealth") != nil {
            squareCurrentHealth = UserDefaults.standard.object(forKey: "squareCurrentHealth") as! Int
        }
        if UserDefaults.standard.object(forKey: "playerMaxHealth") != nil {
            playerMaxHealth = UserDefaults.standard.object(forKey: "playerMaxHealth") as! Int
        }
        if UserDefaults.standard.object(forKey: "playerCurrentHealth") != nil {
            playerCurrentHealth = UserDefaults.standard.object(forKey: "playerCurrentHealth") as! Int
        }
        if UserDefaults.standard.object(forKey: "coins") != nil {
            coins = UserDefaults.standard.object(forKey: "coins") as! Int
        }
        if UserDefaults.standard.object(forKey: "coinWorth") != nil {
            coinWorth = UserDefaults.standard.object(forKey: "coinWorth") as! Int
        }
        if UserDefaults.standard.object(forKey: "coinReward") != nil {
            coinReward = UserDefaults.standard.object(forKey: "coinReward") as! Int
        }
        if UserDefaults.standard.object(forKey: "playerDamage") != nil {
            playerDamage = UserDefaults.standard.object(forKey: "playerDamage") as! Int
        }
        if UserDefaults.standard.object(forKey: "damageCost") != nil {
            damageCost = UserDefaults.standard.object(forKey: "damageCost") as! Int
        }
        if UserDefaults.standard.object(forKey: "level") != nil {
            level = UserDefaults.standard.object(forKey: "level") as! Int
        }
        if UserDefaults.standard.object(forKey: "projectileDamage") != nil {
            projectileDamage = UserDefaults.standard.object(forKey: "projectileDamage") as! Int
        }
        if UserDefaults.standard.object(forKey: "isGamePaused") != nil {
            isGamePaused = UserDefaults.standard.object(forKey: "isGamePaused") as! Bool
        }
        
        //projectileMovement()
    }
    
    @objc func projectileMovement() {//Could use a classic func with different timer
        
        let removeDoodle = SKAction.removeFromParent()
        //let bol = true
        while projCounter <= 20{
            //Create an if... that checks for existence; if it does, do nothing (cause for... to run again; else, do the code and break)
            print("Counter: \(projCounter)")
            projectiles[projCounter] = SKSpriteNode(imageNamed: "projectile_1")//There needs to be a switch statement to change textures based on level
            projectiles[projCounter].position = CGPoint(x: 0, y: 0)
            self.addChild(projectiles[projCounter])
            projectiles[projCounter].zPosition = 2//Prev 1
            projectiles[projCounter].name = "projectile"
            
            print("Projectile created")
            let random = Int.random(in: -200 ..< 200)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: random, y: 700))
            path.addLine(to: CGPoint(x: random, y: -600))
            let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
            
            projectiles[projCounter].run(SKAction.sequence([
                move,
                removeDoodle
            ]), withKey: "runProjectiles")//Named the action
            if projCounter >= 20 {
                projCounter = 1
            }
            projCounter += 1
            break
            //}
        }
    }
    
    @objc func bloomCreation() {
        let expl = SKSpriteNode(imageNamed: "bloom_blank")
        expl.position = CGPoint(x: -10000, y: -10000)
        self.addChild(expl)
        expl.zPosition = 3
        expl.name = "bloomTest"
        
        //var this = SKAction.setTexture(SKTexture(imageNamed: "bloom_1"))
        var counting = times[bloomCounter]
        //var currentBloom = blooms[bloomCounter]
        bloomTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            
            if counting == 0 {
                expl.texture = SKTexture(imageNamed: "bloom_3")
                print("3")
            } else if counting == 1 {
                expl.texture = SKTexture(imageNamed: "bloom_2")
                print("2")
            } else if counting == 2 {
                expl.texture = SKTexture(imageNamed: "bloom_1")
                print("1")
            } else if counting == 3 {
                print("BOOM")
                //self.blooms[self.bloomCounter].texture = SKTexture(imageNamed: "square_break_4")
                self.playerCurrentHealth -= 20 * self.bloomDmgMult
                expl.removeFromParent()
                Timer.invalidate()
            }
            counting += 1
        }
        
        bloomTimers.append(bloomTimer)
        print("Bloom timer count: \(bloomTimers.count)")
        
        print("Bloom created")
        let randomX = Int.random(in: -250 ..< 250)
        let randomY = Int.random(in: -200 ..< 300)//Look into the coords
        expl.position = CGPoint(x: randomX, y: randomY)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var currentBloomTimer = bloomTimers.count - 1
        //if childNode(withName: "bloomTest").
        let val: SKSpriteNode = childNode(withName: "bloomTest") as? SKSpriteNode ?? SKSpriteNode(imageNamed: "bloom_blank")
        
        guard let touch = touches.first else {return}
        let squareLocation = touch.location (in: self)
        let projectileLocation = touch.location(in: self)
        let bloomLocation = touch.location(in: self)
        let damageShopLocation = touch.location(in: self)
        var projectileTapped = true
        var bloomTapped = true
        
        for projectile in projectiles{
            
            if projectile.contains(projectileLocation) {
                projectile.position = CGPoint(x: -100000, y: -100000)//Temp solution?
                projectile.removeFromParent()
                print("Doodle broken")

                projectileTapped = false
            }
        }
        
        if val.contains(bloomLocation) {
            print("Popped!")
            val.removeFromParent()
            if !bloomTimers.isEmpty {
                //bloomTimers[currentBloomTimer].invalidate()
            //print("Before removal: \(bloomTimers.count)")
                bloomTimers.remove(at: bloomTimers.count - 1).invalidate()
            //print("After removal: \(bloomTimers.count)")
                //bloomTimers.remove(at: currentBloomTimer)
            }
            bloomTapped = false
            //playerCurrentHealth += 20 * bloomDmgMult
            //bloomTimer.invalidate()//May invalidate all timers
        }
        
        if square.contains(squareLocation) && projectileTapped && bloomTapped{
            coins += coinWorth
            print("Coins: \(coins)")
            squareCurrentHealth -= playerDamage
            print("Health: \(squareCurrentHealth)/\(squareMaxHealth)")
            squareHealthChecker()
        }
        
        if damageShop.contains(damageShopLocation) && projectileTapped{
            if coins >= damageCost {
                coins -= damageCost
                playerDamage = Int(Double(playerDamage) + (Double(playerDamage) * (1/5)))
                damageCost = Int(Double(damageCost) + (Double(damageCost) * (2/5)))
            }
            print("Coins: \(coins); Damage: \(playerDamage); Cost for Damage: \(damageCost)")
        }
        print("Current player health: \(playerCurrentHealth)")
        print("-----------------------------")
    }
    
    /*
     This may be relocated; makes sure the music is playing throughout the game (should change based on visible attacks)
     */
    
    func squareHealthChecker () {//Could be renamed to healthChecker and take in health of all enemies
        if squareCurrentHealth < Int(Double(squareMaxHealth) * (4.0/5.0)) {
            //            print("value: \(value)")
            //            print("Val2: \(String(describing: val2))")
            square.texture = SKTexture(imageNamed: "square_break_1")
            print("Some seperater")
        }
        if squareCurrentHealth < Int(Double(squareMaxHealth) * (3.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_2")
        }
        if squareCurrentHealth < Int(Double(squareMaxHealth) * (2.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_3")
        }
        if squareCurrentHealth < Int(Double(squareMaxHealth) * (1.0/5.0)) {
            square.texture = SKTexture(imageNamed: "square_break_4")
        }
        
        if squareCurrentHealth <= 0 {
            coins += coinReward
            square.texture = SKTexture(imageNamed: "square")
            levelIncrease()
            //Call a function that does a short animation involving what's underneath the square
            levelChanges()
        }
    }
    
    func levelIncrease (/*_ level: inout Int, _ squareMaxHealth: inout Int, _ squareCurrentHealth: inout Int*/) {//_ inout may not solve; try return?
        level = level + 1
        squareMaxHealth = Int(Double(squareMaxHealth) + (Double(squareMaxHealth) * 0.55))//0.25 is a temporary increase
        squareCurrentHealth = squareMaxHealth
        print(level)
    }
    
    func levelChanges() {
        underIsSeen = true
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
            projectileTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(projectileMovement), userInfo: nil, repeats: true)
            
            
        } else if level == 6 && underIsSeen == true{
            //pause(paused: true)
        } else if level == 15 {//Should stop all activity
            for counter in 0...20 {
                projectiles[counter].texture = SKTexture(imageNamed: "projectile_2")
            }
        } else if level == 20 {
            //Change the background
        } else if level == 25 {
            //Change the square and add blooms
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
    
    func setUserDefaults() {
        UserDefaults.standard.set(playerDeaths, forKey: "playerDeaths")//How many times a player died
        UserDefaults.standard.set(0, forKey: "playerCoins")//Grants player coins after death for completing a certain amount of levels; calculate coins based on the current level - 5 ("-5" subtracts the basic levels before the projectiles)
        UserDefaults.standard.set(underIsSeen, forKey: "underIsSeen")
        UserDefaults.standard.set(squareMaxHealth, forKey: "squareMaxHealth")
        UserDefaults.standard.set(squareCurrentHealth, forKey: "squareCurrentHealth")
        UserDefaults.standard.set(playerMaxHealth, forKey: "playerMaxHealth")
        UserDefaults.standard.set(playerCurrentHealth, forKey: "playerCurrentHealth")
        UserDefaults.standard.set(coins, forKey: "coins")
        UserDefaults.standard.set(coinWorth, forKey: "coinWorth")
        UserDefaults.standard.set(coinReward, forKey: "coinReward")
        UserDefaults.standard.set(playerDamage, forKey: "playerDamage")
        UserDefaults.standard.set(damageCost, forKey: "damageCost")
        UserDefaults.standard.set(level, forKey: "level")
        UserDefaults.standard.set(projectileDamage, forKey: "projectileDamage")
        
        UserDefaults.standard.set(isGamePaused, forKey: "isGamePaused")//Might not belong here
    }
    
    override func update(_ currentTime: TimeInterval) {
        collisions()
        playerHealthChecker()
        setUserDefaults()
        //bloomBoom()
        //print("Timer: \(bloomTimers[1].timeInterval)")
        
        /*
         if !aPlayer.isPlaying {
         aPlayer.play()
         }
         */
        
        //Create a method that sets all standards; when the app starts, set the standards to that variables IF the variables have already been used
    }
}

/*
 The following are some tutorials used to build the sprites and environments of the game:
 "SpriteKit Particle Emitters - Swift - Xcode 10" by Sean Allen
 "iOS Swift Game Tutorial: SpriteKit Space Game (with Explosions)" by Brian Advent
 Paul Hudson
 
 "" by
 */
//SKAction.perform(<#T##selector: Selector##Selector#>, onTarget: <#T##Any#>)
//SKAction.customAction(withDuration: <#T##TimeInterval#>, actionBlock: <#T##(SKNode, CGFloat) -> Void#>)
//SKAction.playSoundFileNamed(<#T##soundFile: String##String#>, waitForCompletion: <#T##Bool#>)
//For the if statements, create an SKAction var and run it???

