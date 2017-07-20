//
//  ViewController.swift
//  ShootEmUp
//
//  Created by etna on 18/07/2017.
//  Copyright © 2017 PrepETNA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lama: UIImageView!
    @IBOutlet var enemies: [UIImageView]!

    var animationForLama: UIViewPropertyAnimator!
    var location = CGPoint(x: 0, y: 0)
    var verif: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enemies.forEach{(img: UIImageView) in
            animateEnnemy(img)
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.detectColision), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touché")
        if let touch = touches.first {
            location = touch.location(in: self.view)
            if (lama.layer.frame.contains(location)) {
                self.verif = true
            }
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.verif) {
            // print("mouvé", lama.center)
            if let touch = touches.first {
                location = touch.location(in: self.view)
                lama.center = location
            }
            super.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.verif = false
    }

    
    @objc private func detectColision(_ enemy: UIImageView){

            enemies.forEach{(img: UIImageView) in
                if (lama.layer.frame.intersects((img.layer.presentation()?.frame)!)) {
                    print("COLLISION")
                }
            }
        }

    private func animateEnnemy(_ img: UIImageView){
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

