//
//  MenuViewController.swift
//  BreakTheSquareGame
//
//  Created by cory on 2/29/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    
    var value: Int = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onStartGame(_ sender: Any) {
        performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    
    @IBAction func onOpenTutorial(_ sender: Any) {
        performSegue(withIdentifier: "tutorialSegue", sender: nil)
    }
    
    @IBAction func onOpenCredits(_ sender: Any) {
        performSegue(withIdentifier: "creditsSegue", sender: nil)
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
