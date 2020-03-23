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
    
    @IBAction func onPause(_ sender: Any) {
        //There will be a menu here that pauses game
        //        Alert(title: Text(scoreTitle), message: Text("Your score: \(userScore)"), dismissButton: .default(Text("Continue")){
        //        self.askQuestion()
        //        })
        let alert: UIAlertController = UIAlertController(title: "Break the Square", message: "Paused", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in
            //Contains the countdown to continue?
        })
        alert.addAction(UIAlertAction(title: "Back to Menus", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
