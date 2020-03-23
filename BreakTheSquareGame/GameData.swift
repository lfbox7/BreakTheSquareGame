//
//  GameData.swift
//  BreakTheSquareGame
//
//  Created by cory on 3/22/20.
//  Copyright © 2020 royalty. All rights reserved.
//

import UIKit
import SpriteKit

class GameData {
    func pause(projectiles: [SKSpriteNode], paused: Bool) {//Could require a bool to continue looping the freezing of the projectile/bloom movement/countdown
        while(paused) {
            for counter in 1...20 {
                var projectileX = projectiles[counter].position.x
                var projectileY = projectiles[counter].position.y
                projectiles[counter].position = CGPoint(x: projectileX, y: projectileY)
            }
        }
    }
}
