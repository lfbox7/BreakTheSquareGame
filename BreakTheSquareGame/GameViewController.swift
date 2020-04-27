//
//  GameViewController.swift
//  BreakTheSquareGame
//
//  Created by cory on 2/27/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    //let game: GameData! =
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    //let game: GameScene = GameScene()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func death() {
        //performSegue(withIdentifier: "menuSegue", sender: nil)
        //self.dismiss(animated: true, completion: nil)
        print("THIS IS THE BIT THAT STILL DOESNT WORK REEEEEEEE")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPause(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//        let scene: GameScene = GameScene()
//        scene.pause(paused: true)
        //GameScene.pause(GameScene)
        
        
        //There will be a menu here that pauses game
        //        Alert(title: Text(scoreTitle), message: Text("Your score: \(userScore)"), dismissButton: .default(Text("Continue")){
        //        self.askQuestion()
        //        })
        
        
//        game.pause(paused: true)
//        let alert: UIAlertController = UIAlertController(title: "Break the Square", message: "Paused", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in
//
//            game.pause(paused: false)
//            game.someCount = 1//Requires "self" for accurate/updated? Or use standard
//        })
//        alert.addAction(UIAlertAction(title: "Back to Menus", style: .default) { (UIAlertAction) in
//            self.dismiss(animated: true, completion: nil)
//        })
//        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
