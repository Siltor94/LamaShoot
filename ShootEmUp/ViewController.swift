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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enemies.forEach{(img: UIImageView) in
            animateEnnemy(img)
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.detectColision), userInfo: nil, repeats: true)
    }
    
    @IBAction func moveTUIButton(_ sender: UIButton) {
        animationForLama.stopAnimation(false)
    }

    @IBAction func moveTDButton(_ sender: UIButton) {
        animationForLama = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            if sender.tag == 0 {
                self.lama.center.x = sender.frame.origin.x + sender.frame.size.width + self.lama.frame.size.width
            } else {
                self.lama.center.x = self.view.frame.size.width - sender.frame.size.width - self.lama.frame.size.width
            }
        })
        animationForLama.startAnimation()
    }
    
    @objc private func detectColision(_ enemy: UIImageView){

            enemies.forEach{(img: UIImageView) in
                if (lama.layer.presentation()?.frame.intersects((img.layer.presentation()?.frame)!))! {
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

