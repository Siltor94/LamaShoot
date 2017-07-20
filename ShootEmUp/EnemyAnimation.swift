//
//  EnemyAnimation.swift
//  ShootEmUp
//
//  Created by etna on 20/07/2017.
//  Copyright © 2017 PrepETNA. All rights reserved.
//

import UIKit
import Foundation

class EnemyAnimation: ViewController {
    
    public func animateEnnemy(_ img: UIImageView){
        var t: TimeInterval?
        switch img.tag {
        case 1:
            t = TimeInterval(arc4random_uniform(7 - 4) + 4)
            break
        case 2:
            t = TimeInterval(arc4random_uniform(8 - 3) + 3)
            break
        case 3:
            t = TimeInterval(arc4random_uniform(12 - 8) + 8)
            break
        default:
            ()
        }
        
        if let duration = t {
            UIView.animate(withDuration: duration, animations: {
                img.center.y = self.view.frame.size.height + 100
            }, completion: {
                (true) in
                img.center.y = -100
                self.animateEnnemy(img)
            })
        }
    }
}
