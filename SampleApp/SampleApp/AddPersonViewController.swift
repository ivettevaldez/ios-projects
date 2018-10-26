//
//  AddPersonViewController.swift
//  SampleApp
//
//  Created by Silvia on 10/19/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var textNameView: UITextField!
    @IBOutlet weak var textLastNameView: UITextField!
    @IBOutlet weak var textEmailView: UITextField!
    @IBOutlet weak var textProfessionView: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var buttonSaveView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide activity indicator.
        activityIndicatorView?.isHidden = true

        // Disable Sign In button as the fields are empty.
        buttonSaveView?.isEnabled = false

        // Handle the text field's user input through delegate callbacks.
        textNameView?.delegate = self
        textLastNameView?.delegate = self
        textEmailView?.delegate = self
        textProfessionView?.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Enable button only if both fields were filled.
        if (hasFilledFields()) {
            buttonSaveView.isEnabled = true
        } else {
            buttonSaveView.isEnabled = false
        }
    }

    // MARK: Actions and related functions
    
    @IBAction func savePerson(_ sender: UIButton) {
        showToast(message: "Saved!")
        
        // Dismiss View Controller after a delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    private func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    // MARK: Field validations
    
    private func getName() -> String {
        return textNameView?.text ?? ""
    }
    
    private func getLastName() -> String {
        return textLastNameView?.text ?? ""
    }
    
    private func getEmail() -> String {
        return textEmailView?.text ?? ""
    }
    
    private func getProfession() -> String {
        return textProfessionView?.text ?? ""
    }
    
    private func hasFilledFields() -> Bool {
        return !(getName().isEmpty)
            && !(getLastName().isEmpty)
            && !(getEmail().isEmpty)
            && !(getProfession().isEmpty)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
