//
//  InputVC.swift
//  UnitTesting Demo
//
//  Created by Soumil on 16/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import UIKit

var butttonTag = 0
class InputVC: UIViewController {
    let dataManager = WeatherDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextPageNavigator(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segue1",
                     sender: self)
        
        butttonTag = sender.tag
    }
}

