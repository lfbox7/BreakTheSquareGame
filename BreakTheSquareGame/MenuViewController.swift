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
    
    func onDeath() {
        //performSegue(withIdentifier: "menuSegue", sender: nil)
        print("In onDeath")
        let menu = MenuViewController()
        //menu.present(MenuViewController(), animated: true) {}
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
//        present(MenuViewController, animated: true) {
//
//        }
    }
    
    func temp() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let menu = story.instantiateViewController(identifier: "Menu View Controller")
        menu.view.frame = (self.view?.frame)!
        menu.view.layoutIfNeeded()
        
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.view?.window?.rootViewController = menu
        }, completion: nil)
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
