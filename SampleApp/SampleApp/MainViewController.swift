//
//  MainViewController.swift
//  SampleApp
//
//  Created by Hunabsys on 9/18/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Hide back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }

}

