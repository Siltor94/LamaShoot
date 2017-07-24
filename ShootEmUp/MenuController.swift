//
//  MenuController.swift
//  ShootEmUp
//
//  Created by etna on 20/07/2017.
//  Copyright © 2017 PrepETNA. All rights reserved.
//

import Foundation
import UIKit

class MenuController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    let difficulties = ["Easy", "Normal", "Difficult"]
    var difficulty = [0.5, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "playGame" {
            let detailViewController = segue.destination as! ViewController
            detailViewController.difficulty = difficulty as Array
        }
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        print(difficulty)
        performSegue(withIdentifier: "playGame", sender: difficulty)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(difficulties[row])
        if (difficulties[row] == "Easy") {
            print("da")
            difficulty = [0.5, 2]
        } else if (difficulties[row] == "Normal") {
            print("daa")
            difficulty = [1, 1]
        } else {
            difficulty = [2, 0.5]
        }
    }

}
