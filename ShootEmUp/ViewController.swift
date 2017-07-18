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

    var animationForLama: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

