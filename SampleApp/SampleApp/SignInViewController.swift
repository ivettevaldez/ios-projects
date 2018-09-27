//
//  SignInViewController.swift
//  SampleApp
//
//  Created by Hunabsys on 9/18/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var buttonSignInView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
//        buttonSignInView.addTarget(self, action: Selector(("signIn:")), for: UIControlEvents.touchUpInside)

        // Hide the activity indicator until button is clicked
        // self.showActivityIndicator(show: false)
    }
    
    // @IBAction func signIn(sender: UIButton) {
        // print("Clicked!")
        // self.showActivityIndicator(show: true)

        // DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2: Number of seconds
        // }
    // }
    
//    func showActivityIndicator(show: Bool) {
//        activityIndicatorView.isHidden = show
//    }
    
}
