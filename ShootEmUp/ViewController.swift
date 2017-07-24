//
//  ViewController.swift
//  ShootEmUp
//
//  Created by etna on 18/07/2017.
//  Copyright © 2017 PrepETNA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var lama: UIImageView!
    var enemies: Array<UIImageView>! = []
    var shots: Array<UIImageView>! = []
    var shotTimer: Timer!
    var enemyTimer: Timer!
    var colisionTimer: Timer!
    var difficulty:Array<Double>! = [0.5, 2]
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    
    @IBOutlet weak var deathMessage: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    
    var animationForLama: UIViewPropertyAnimator!
    var location = CGPoint(x: 0, y: 0)
    var verif: Bool! = false
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var score = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController ==> ")
        deathMessage.isHidden = true
        retryButton.isHidden = true
        scoreLabel.text = String(score)
        
        print("daaa ", difficulty[0])
        print(difficulty[1])
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "el-OST", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print(error)
        }
        
        self.screenHeight = self.view.frame.size.height
        self.screenWidth = self.view.frame.size.width
        let image: UIImage = UIImage(named: "lama2")!
        
        self.lama = UIImageView(image: image)
        self.lama.frame = CGRect(x: (self.screenWidth / 2) - (self.lama.frame.size.width / 2), y: (self.screenHeight / 1.1) - (self.lama.frame.size.height / 2), width: self.lama.frame.size.width, height: self.lama.frame.size.height)
        self.view.addSubview(self.lama)
        
        location = CGPoint(x: (self.screenWidth / 2) , y: (self.screenHeight / 1.1))
        
        // NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // projectile
        shotTimer = Timer.scheduledTimer(timeInterval: difficulty[0], target: self, selector: #selector(self.spit_it), userInfo: nil, repeats: true)
        // ennemie
        enemyTimer = Timer.scheduledTimer(timeInterval: difficulty[1], target: self, selector: #selector(self.spawn_enemy), userInfo: nil, repeats: true)
        // verif
        colisionTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.detectColision), userInfo: nil, repeats: true)
    }
    
    func rotate () {
        print ("aaaarrrghhhhhhhhhh")
    }
    
    @IBAction func ReturnMenu(_ sender: UIButton) {
        print("return")
        audioPlayer.stop()
        enemyTimer.invalidate()
        colisionTimer.invalidate()
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    func spawn_enemy () {
        let randomNumber = arc4random_uniform(UInt32(self.view.frame.width - 50))
        let image: UIImage = UIImage(named: "el-gato-terriblo")!
        let enemy = UIImageView(image: image)
//        enemy.contentMode = UIViewContentMode.scaleAspectFit
//        enemy.frame = CGRect(x: Int(randomNumber), y: 0, width: 50, height: 50)
        enemy.frame = CGRect(x: Int(randomNumber), y: 0, width: Int(enemy.frame.width), height: Int(enemy.frame.height))

        self.view.addSubview(enemy)
        self.enemies.append(enemy)
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveLinear, animations: {
            enemy.center.y = self.view.frame.height
        }, completion: {finished in
            enemy.removeFromSuperview()
            self.enemies.removeFirst()
        })
    }
    
    func spit_it () {
        
        let image: UIImage = UIImage(named: "el-crachato")!
        let spit = UIImageView(image: image)
        spit.frame = CGRect(x: location.x - 5, y: location.y - self.lama.frame.height, width: 15, height: 30)
        self.view.addSubview(spit)
        self.shots.append(spit)
        
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            spit.center.y = 0
        }, completion: {finished in
            spit.removeFromSuperview()
            self.shots.removeFirst()
        })
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (lama.layer.frame.contains(touch.location(in: self.view))) {
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
    
    // DETECTION DE COLLISION
    @objc private func detectColision(_ enemy: UIImageView){
        
        enemies.forEach{(enemy: UIImageView) in
            // print(img.layer.presentation()?.frame ?? CGRect(x: 0, y: 0, width: 15, height: 30))
            if (lama.layer.frame.intersects((enemy.layer.presentation()?.frame) ?? CGRect(x: -400, y: -400, width: 15, height: 30))) {
                print("COLLISION")
                enemy.layer.removeAllAnimations()
                lama.removeFromSuperview()
                shotTimer.invalidate()
                deathMessage.isHidden = false
                retryButton.isHidden = false
            }
            shots.forEach{(shot: UIImageView) in
                if ((shot.layer.presentation()?.frame ?? CGRect(x: -600, y: -400, width: 15, height: 30)).intersects((enemy.layer.presentation()?.frame) ?? CGRect(x: -400, y: -400, width: 15, height: 30))) {
                    print("spittttt COLLISION")
                    enemy.layer.removeAllAnimations()
                    shot.layer.removeAllAnimations()
                    score = score + 1
                    scoreLabel.text = String(score)
                }
            }
        }
    }
}

