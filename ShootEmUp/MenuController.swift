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

    var gameParams: [String] = ["test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
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
        setterdelamuerte(test: difficulties[row])
        print("Avant de get ==> ")
        print(self.gameParams)
    }
    
    func setterdelamuerte(test: String){
        self.gameParams.append(test)
    }
    
    func getGameParams() -> [String]{
        print("Dans le get ==> ")
        print(self.gameParams)
        return self.gameParams
    }
}
