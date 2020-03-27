//
//  GameData.swift
//  BreakTheSquareGame
//
//  Created by cory on 3/22/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameData {
    
    /*
     Contains the creation of sprites
     */

    
//    @objc func projectileMovement() {
//        let removeDoodle = SKAction.removeFromParent()
//        //let bol = true
//        while counter <= 20{
//            //Create an if... that checks for existence; if it does, do nothing (cause for... to run again; else, do the code and break)
//            //if isCreated[counter] == false {
//            projectiles[counter] = SKSpriteNode(imageNamed: "projectile_1")
//            projectiles[counter].position = CGPoint(x: 0, y: 0)
//            self.addChild(projectiles[counter])
//            projectiles[counter].zPosition = 2//Prev 1
//            projectiles[counter].name = "projectile"
//
//            print("Created")
//            let random = Int.random(in: -200 ..< 200)
//
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: random, y: 700))
//            path.addLine(to: CGPoint(x: random, y: -600))
//            let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 50)
//
//            projectiles[counter].run(SKAction.sequence([
//                move,
//                removeDoodle
//            ]))
//            //isCreated[counter] = true
//            if counter >= 20 {
//                counter = 1
//            }
//            counter += 1
//            break
//            //}
//        }
//    }
    
//    func bloomMovement() {
//
//    }
    

    

    

    

    
//    func onPause() {
//        pause(paused: true, test: projectiles)
//        let alert: UIAlertController = UIAlertController(title: "Break the Square", message: "Paused", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in
//
//            self.pause(paused: false, test: self.projectiles)
//            self.someCount = 1//Requires "self" for accurate/updated? Or use standard
//        })
//        alert.addAction(UIAlertAction(title: "Back to Menus", style: .default) { (UIAlertAction) in
//            //dismiss(animated: true, completion: nil)
//            alert.dismiss(animated: true, completion: nil)
//        })
//        alert.present(alert, animated: true, completion: nil)
//    }
//
//    func pause(paused: Bool, test: [SKSpriteNode]) {//Could require a bool to continue looping the freezing of the projectile/bloom movement/countdown
//        if paused {
//
//            //var pos: [Int]
//            if checker {
//                for counter in 1...20 {
//                    print(counter)
//                    projectiles[counter].removeAction(forKey: "runProjectiles")//If pasued before projectiles, crashes before projectiles because they dont exist yet;
//                }
//
//                projectileTimer.invalidate()
//                //                for counter in 0...19 {
//                //
//                //                    //SKAction.can
//                //
//                //                    positionsX[counter] = Int(projectiles[counter + 1].position.x)
//                //                    print("Position at \(counter) x: \(positionsX[counter])")
//                //                    positionsY[counter] = Int(projectiles[counter + 1].position.y)
//                //                    print("Position at \(counter) y: \(positionsY[counter])")
//                //                }
//                checker = false
//            }
//            //            for counter in 1...20 {
//            //                projectileTimer.invalidate()
//            //                projectiles[counter].position = CGPoint(x: positionsX[counter - 1]!, y: positionsY[counter - 1]!)
//            //            }
//            //}
//        } else if paused == false {
//            //if checker {
////            projectileTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(projectileMovement), userInfo: nil, repeats: true)
//            //}
//        }
//    }
    
    /*
     This may be relocated; makes sure the music is playing throughout the game (should change based on visible attacks)
     */
}
