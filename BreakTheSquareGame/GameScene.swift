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
    
    var underIsSeen = false
    var squareMaxHealth = 100
    var squareCurrentHealth = 100
    var playerMaxHealth = 100//100
    var playerCurrentHealth = 100//100
    var coins = 0//In-game currency
    var coinWorth = 20//
    var coinReward = 20//
    var playerDamage = 5//5
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
    var blooms: [SKSpriteNode] = []
    var bloomCountDown: Timer!
    var bloomTimers: [Timer] = []
    var (timed1, timed2, timed3, timed4, timed5, timed6, timed7, timed8, timed9, timed10) = (0,0,0,0,0,0,0,0,0,0)
    var times: [Int] = []
    var timed = 0
    var timeInterval = 5.0
    var bloomDmgMult = 1
    
    var isPlaying: Bool = true
    
    var aPlayer = AVAudioPlayer()//Audio player
    
    private let files: GameFiles = GameFiles()
    private let game = GameViewController()
    
    override func didMove(to view: SKView) {
        //let view = UIView()
        
        //setUserDefaults()
        
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
        damageShop = SKSpriteNode(imageNamed: "shop_damage")
        self.addChild(damageShop)
        damageShop.position = CGPoint(x: -165, y: -500)
        damageShop.zPosition = 3
        
        preparation()
        
        if level >= 5 {
            projectileTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(projectileMovement), userInfo: nil, repeats: true)
        }
        if level >= 10 {
            bloomCountDown = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(bloomCreation), userInfo: nil, repeats: true)
        }
    }
    
    func preparation() {//Left in here to set standard defaults
        
        //setUserDefaults()//Used to reset values back to default; will be controlled by button in credits
        
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
    }
    
    @objc func projectileMovement() {
        let removeDoodle = SKAction.removeFromParent()
        //let bol = true
        while projCounter <= 20{
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
        }
    }
    
    @objc func bloomCreation() {
        let expl = SKSpriteNode(imageNamed: "bloom_blank")
        expl.position = CGPoint(x: -10000, y: -10000)
        self.addChild(expl)
        expl.zPosition = 3
        expl.name = "bloomTest"
        var counting = times[bloomCounter]
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
                bloomTimers.remove(at: bloomTimers.count - 1).invalidate()
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
        if level == 1 && underIsSeen {
            isPlaying = true
        }
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
            isPlaying = true
            
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
        } else if level == 10 {//Should stop all activity
            isPlaying = true
            bloomCountDown = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(bloomCreation), userInfo: nil, repeats: true)
        } else if level == 20 {
            //Change the background
        } else if level == 25 {
            //Change the square and add blooms
        }
        
        
    }
    
    func playerHealthChecker() {
        if playerCurrentHealth <= 0 {
            print("End game")
            self.view?.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            self.removeAllActions()
            self.removeAllChildren()
            projectileTimer.invalidate()
            //bloomTimer!.invalidate()
            bloomCountDown.invalidate()
            for count in 0 ..< bloomTimers.count {
                bloomTimers[count].invalidate()
            }
            playerCurrentHealth = 100
            playerMaxHealth = 100
            underIsSeen = false
            squareMaxHealth = 100
            squareCurrentHealth = 100
            coins = 0
            coinWorth = 20//SOMETHING HERE
            coinReward = 20
            playerDamage = 5//5
            damageCost = 10
            level = 0//Counter that changes difficulty and various game aspects
            projectileDamage = 5//Will change based on level
            isGamePaused = false
            checker = true//This statement will be outside, or in a UserDefault
            positionsX = [Int?](repeating: 0, count: 20)//Creates an array of size 20 filled with nils
            positionsY = [Int?](repeating: 0, count: 20)
            someCount = 0
            projCounter = 1//Loops the projectiles
            bloomCounter = 0//Loops the blooms
            hit = 0//Tests if player is hit
            isPlaying = true//
            
            UserDefaults.standard.set(playerDeaths, forKey: "playerDeaths")
            UserDefaults.standard.set(0, forKey: "playerCoins")
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
            UserDefaults.standard.set(isGamePaused, forKey: "isGamePaused")
            UserDefaults.standard.set(100, forKey: "playerMaxHealth")
            UserDefaults.standard.set(100, forKey: "playerCurrentHealth")
            
            /*
             This needs to restart EVERYTHING
             */
            print(playerMaxHealth)
            print(playerCurrentHealth)
            
            /*
             var playerDeaths = 0
             var gameBackground: SKSpriteNode!//The background of the game
             var square: SKSpriteNode!//The square to tap
             var player: SKSpriteNode!//The player
             var underSquare: SKSpriteNode!//What is underneath the square???
             var damageShop: SKSpriteNode!//Increases damage
             var (doodle0, doodle1, doodle2, doodle3, doodle4, doodle5, doodle6, doodle7, doodle8, doodle9, doodle10, doodle11, doodle12,doodle13, doodle14, doodle15, doodle16, doodle17, doodle18, doodle19, doodle20) = (SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"), SKSpriteNode(imageNamed: "projectile_1"))
             var projectiles: [SKSpriteNode] = []
             var (bloom0, bloom1, bloom2, bloom3, bloom4, bloom5, bloom6, bloom7, bloom8, bloom9, bloom10) = (SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"), SKSpriteNode(imageNamed: "bloom_blank"))
             var blooms: [SKSpriteNode] = []
             var bloomTimers: [Timer] = []
             var (timed1, timed2, timed3, timed4, timed5, timed6, timed7, timed8, timed9, timed10) = (0,0,0,0,0,0,0,0,0,0)
             var times: [Int] = []
             var timed = 0
             var timeInterval = 5.0
             var bloomDmgMult = 1
             var isPlaying: Bool = false
             */
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
    
    func musicPlayer() {
        if ((level >= 1 && level <= 4) && isPlaying) {
//            let sound = Bundle.main.path(forResource: "General Music", ofType: "mp3")
//
//            do {
//                aPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//            }
//            catch{
//                print("Something happened: \(error)")
//            }
//            isPlaying = false
            
            if let asset = NSDataAsset(name: "General Music") {
                do {
                    aPlayer = try AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
                    //play sound
                } catch let error as NSError {
                    print("Whoops! Music problem")
                }
            }
            isPlaying = false
            
        } else if((level >= 5 && level <= 9) && isPlaying) {
//            let sound = Bundle.main.path(forResource: "Middle Music", ofType: "mp3")
//
//            do {
//                aPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//            }
//            catch{
//                print("Something happened: \(error)")
//            }
            
            if let asset = NSDataAsset(name: "Middle Music Full") {
                do {
                    aPlayer = try AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
                    //play sound
                } catch let error as NSError {
                    print("Whoops! Music problem")
                }
            }
            isPlaying = false
            
            isPlaying = false
        } else if((level >= 10) && isPlaying) {
//            let sound = Bundle.main.path(forResource: "Faster Music", ofType: "mp3")
//
//            do {
//                aPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//            }
//            catch{
//                print("Something happened: \(error)")
//            }
//            isPlaying = false
            
            if let asset = NSDataAsset(name: "Faster Music") {
                do {
                    aPlayer = try AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
                    //play sound
                } catch let error as NSError {
                    print("Whoops! Music problem")
                }
            }
            
            isPlaying = false
        }
        
        if !aPlayer.isPlaying {
            aPlayer.play()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        collisions()
        playerHealthChecker()
        setUserDefaults()
        musicPlayer()
    }
    
    
}

/*
 The following are some tutorials used to build the sprites and environments of the game:
 "SpriteKit Particle Emitters - Swift - Xcode 10" by Sean Allen
 "iOS Swift Game Tutorial: SpriteKit Space Game (with Explosions)" by Brian Advent
 Paul Hudson
 
 "" by
 */
