//
//  GameFiles.swift
//  BreakTheSquareGame
//
//  Created by cory on 3/24/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import Foundation
import SpriteKit

//class Sci{
//    var x: Int = 0
//    func print(){
//        x = x + 1
//        print(x)
//    }
//}
//
//class An: Sci {
//
//}

class GameFiles/*: GameScene*/ {
    
    func test () {
        let red, green, blue: Double
    }

    /*
     THIS IS WHERE PREPARATION WENT
     */
    /*
     let sound = Bundle.main.path(forResource: "First Levels (Synth)", ofType: "mp3")
     do {
     aPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
     } catch {
     print("Error with music")
     }
     */
    
    /*
     Some notes on what is needed to do:
     Copy and paste the menus and recreate the imagery in Main.storyboard
     Add dmg+ and hlth+
     */
    

    
//    @objc func projectileMovement() {
//        let removeDoodle = SKAction.removeFromParent()
//        //let bol = true
//        while projCounter <= 20{
//            //Create an if... that checks for existence; if it does, do nothing (cause for... to run again; else, do the code and break)
//            //if isCreated[counter] == false {
//            //print("Counter: \(projCounter)")
//            projectiles[projCounter] = SKSpriteNode(imageNamed: "projectile_1")//There needs to be a switch statement to change textures based on level
//            projectiles[projCounter].position = CGPoint(x: 0, y: 0)
//            scene.self.addChild(projectiles[projCounter])
//            projectiles[projCounter].zPosition = 2//Prev 1
//            projectiles[projCounter].name = "projectile"
//
//            print("Created")
//            let random = Int.random(in: -200 ..< 200)
//
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: random, y: 700))
//            path.addLine(to: CGPoint(x: random, y: -600))
//            let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
//
//            projectiles[projCounter].run(SKAction.sequence([
//                move,
//                removeDoodle
//            ]), withKey: "runProjectiles")//Named the action
//            //isCreated[counter] = true
//            if projCounter >= 20 {
//                projCounter = 1
//            }
//            projCounter += 1
//            break
//            //}
//        }
//    }
}

/*
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
 levelChanges()//This needs to be in data...
 
 }
 
 
 }
 
 func levelIncrease () {
 squareMaxHealth = Int(Double(squareMaxHealth) + (Double(squareMaxHealth) * 0.55))//0.25 is a temporary increase
 squareCurrentHealth = squareMaxHealth
 
 //underIsSeen = true
 //theUnderneath()
 }
 
 func levelChanges() {
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
 projectileTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(projectileMovement), userInfo: nil, repeats: true)
 } else if level == 6 && underIsSeen == true{
 //pause(paused: true)
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
 */
