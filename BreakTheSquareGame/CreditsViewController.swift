//
//  CreditsViewController.swift
//  BreakTheSquareGame
//
//  Created by cory on 3/1/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    var game: GameScene = GameScene()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let coinsDisplay: Int = game.coins
        print(UserDefaults.standard.object(forKey: "coins") as! Int)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackToMenus(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
